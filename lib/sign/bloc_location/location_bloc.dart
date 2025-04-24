import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

import 'package:equatable/equatable.dart';
import 'package:signclock/sign/services/current_location_isValid.dart';
import 'package:signclock/api_services/sign_services.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/model/sign_model.dart';
import 'package:signclock/sign/services/app_error.dart';
import 'package:signclock/sign/location_repo/current_user_location_entity.dart';
import 'package:signclock/sign/location_repo/location_repository.dart';

import 'package:json_annotation/json_annotation.dart';

part 'location_event.dart';
part 'location_bloc.g.dart';
part 'location_state.dart';

class LocationBloc extends HydratedBloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;
  final AuthHyBloc authBloc;
  final SignServices signServices;

  LocationBloc({
    required this.locationRepository,
    required this.authBloc,
    required this.signServices,
  }) : super(const LocationState()) {
    on<InitEvent>(_handleInitEvent);
    on<InitWorkingEvent>(_handleSignEvent);
    on<InitRestingEvent>(_handleSignEvent);
    on<ReturnWorkingEvent>(_handleSignEvent);
    on<GoOutEvent>(_handleSignEvent);
    on<CancelEvent>(_handleCancelEvent);
  }

  Future<void> _handleInitEvent(
      InitEvent event, Emitter<LocationState> emit) async {
    final AuthHyState authState;
    if (!authBloc.state.isAuthenticated || authBloc.state.token == null) {
      try {
        authState = await authBloc.stream
            .firstWhere((state) => state.isAuthenticated && state.token != null)
            .timeout(const Duration(seconds: 5));
      } catch (e) {
        _emitErrorState(
            const AppError('No se pudo confirmar la autenticación'), emit);
        return;
      }
    } else {
      authState = authBloc.state;
    }

    if (authState.user == null) {
      _emitErrorState(
          const AppError('Estado de autenticación inconsistente: Usuario nulo'),
          emit);
      return;
    }
    final currentUser = authState.user!;

    _emitLoadingState(emit);
    try {
      await _emitStateFromLastSign(currentUser.lastSign, emit);
    } catch (e) {
      _emitErrorState(e, emit);
    }
  }

  Future<void> _handleSignEvent(
      LocationEvent event, Emitter<LocationState> emit) async {
    _emitLoadingState(emit);
    try {
      await _validateLocationAndProcessSign(event, emit);
    } on AppError catch (e) {
      _emitErrorState(e, emit);
    }
  }

  Future<void> _validateLocationAndProcessSign(
      LocationEvent event, Emitter<LocationState> emit) async {
    final authState = authBloc.state;
    if (!authState.isAuthenticated ||
        authState.token == null ||
        authState.user == null) {
      _emitErrorState(
          const AppError('Usuario no autenticado para fichar'), emit);
      return;
    }

    final currentLocation = await locationRepository.getCurrentLocation();

    if (!currentLocation.isValid()) {
      throw const ValidationError('Ubicación no válida');
    }

    final signData = _buildSignModel(event, currentLocation);
    final signType =
        await signServices.hadleSign(signData, authBloc, signServices);

    if (signType != null) {
      _emitStateFromLastSign(signType, emit, currentLocation);
    }
  }

  void _handleCancelEvent(CancelEvent event, Emitter<LocationState> emit) {
    emit(state.copyWith(status: LocationStateStatus.outside));
  }

  SignModel _buildSignModel(
      LocationEvent event, CurrentUserLocationEntity currentLocation) {
    final currentPhoneModel = authBloc.state.user;
    if (currentPhoneModel == null) {
      throw StateError('PhoneModel es null en _buildSignModel');
    }

    return SignModel(
      groupPhoneId: currentPhoneModel.groupPhoneId,
      currentdate: DateTime.now(),
      currenttime: _getFormattedTime(),
      lat: currentLocation.latitude,
      lon: currentLocation.longitude,
      validated: true,
      type: _getSignTypeFromEvent(event),
    );
  }

  Future<void> _emitStateFromLastSign(
      String lastSign, Emitter<LocationState> emit,
      [CurrentUserLocationEntity? currentLocation]) async {
    final currentPhoneModel = authBloc.state.user;
    if (currentPhoneModel == null) {
      if (!emit.isDone) {
        _emitErrorState(
            const AppError('Usuario no disponible en _emitStateFromLastSign'),
            emit);
      }
      return;
    }

    final initialStatus = {
          'E': LocationStateStatus.working,
          'DE': LocationStateStatus.working,
          'DS': LocationStateStatus.resting,
          'S': LocationStateStatus.outside,
        }[lastSign] ??
        LocationStateStatus.error;
    if (!emit.isDone) {
      emit(state.copyWith(
        status: initialStatus,
        currentUserLocation: currentLocation,
        errorMessage: initialStatus == LocationStateStatus.error
            ? 'Estado local inválido: $lastSign'
            : null,
      ));
    }

    try {
      final apiResponse = await signServices.getActualStatus(currentPhoneModel);

      if (apiResponse.status == "success" && apiResponse.data != null) {
        final String? serverSignType =
            apiResponse.data!['last_sign'] as String?;

        if (serverSignType != null) {
          final serverStatus = {
                'E': LocationStateStatus.working,
                'DE': LocationStateStatus.working,
                'DS': LocationStateStatus.resting,
                'S': LocationStateStatus.outside,
              }[serverSignType] ??
              LocationStateStatus.error;

          if (!emit.isDone) {
            if (kDebugMode) {
              print(
                  "LocationBloc: Server status received (from 'last_sign'): $serverSignType -> $serverStatus");
            }
            emit(state.copyWith(
              status: serverStatus,
              errorMessage: serverStatus == LocationStateStatus.error
                  ? 'Estado del servidor inválido (last_sign): $serverSignType'
                  : null,
            ));
          }
        } else {
          if (!emit.isDone) {
            if (kDebugMode) {
              print(
                  "WARN: Field 'last_sign' missing or invalid in statusInfo response data: ${apiResponse.data}");
            }
          }
        }
      } else if (apiResponse.status == "error") {
        if (!emit.isDone) {
          _emitErrorState(
              AppError('Error API statusInfo: ${apiResponse.msg}'), emit);
        }
      }
    } catch (error) {
      if (!emit.isDone) {
        _emitErrorState(AppError('Error procesando statusInfo: $error'), emit);
      }
    }
  }

  void _emitErrorState(dynamic error, Emitter<LocationState> emit) {
    final errorMessage =
        error is AppError ? error.message : 'Error desconocido $error';

    if (!emit.isDone) {
      emit(state.copyWith(
          status: LocationStateStatus.error, errorMessage: errorMessage));
    }
  }

  void _emitLoadingState(Emitter<LocationState> emit) {
    if (!emit.isDone) {
      emit(state.copyWith(status: LocationStateStatus.loading));
    }
  }

  String _getSignTypeFromEvent(LocationEvent event) {
    return switch (event.runtimeType) {
      InitWorkingEvent => 'E',
      InitRestingEvent => 'DS',
      ReturnWorkingEvent => 'DE',
      _ => 'S',
    };
  }

  String _getFormattedTime() => DateFormat('HH:mm:ss').format(DateTime.now());

  @override
  LocationState? fromJson(Map<String, dynamic> json) =>
      LocationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LocationState state) => state.toJson();
}
