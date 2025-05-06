import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

import 'package:equatable/equatable.dart';
import 'package:signclock/sign/services/current_location_is_valid.dart';
import 'package:signclock/api_services/sign_services.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/models/sign_model.dart';
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
  bool _isProcessingEvent = false;

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
    if (_isProcessingEvent) return;
    _isProcessingEvent = true;

    try {
      final AuthHyState authState;
      if (!authBloc.state.isAuthenticated || authBloc.state.token == null) {
        try {
          authState = await authBloc.stream
              .firstWhere(
                  (state) => state.isAuthenticated && state.token != null)
              .timeout(const Duration(seconds: 5));
        } catch (e) {
          if (!emit.isDone) {
            _emitErrorState(
                const AppError('No se pudo confirmar la autenticación'), emit);
          }
          _isProcessingEvent = false;
          return;
        }
      } else {
        authState = authBloc.state;
      }

      if (authState.user == null) {
        if (!emit.isDone) {
          _emitErrorState(
              const AppError(
                  'Estado de autenticación inconsistente: Usuario nulo'),
              emit);
        }
        _isProcessingEvent = false;
        return;
      }
      final currentUser = authState.user!;

      if (!emit.isDone) {
        _emitLoadingState(emit);
      }

      try {
        final lastSign = currentUser.lastSign;
        final status = {
              'E': LocationStateStatus.working,
              'DE': LocationStateStatus.working,
              'DS': LocationStateStatus.resting,
              'S': LocationStateStatus.outside,
            }[lastSign] ??
            LocationStateStatus.outside;

        if (kDebugMode) {
          print(
              "LocationBloc: InitEvent - Estado inicial según lastSign ($lastSign): $status");
        }

        if (!emit.isDone) {
          emit(state.copyWith(
            status: status,
            errorMessage: null,
          ));
        }
      } catch (e) {
        if (!emit.isDone) {
          _emitErrorState(e, emit);
        }
      }
    } finally {
      _isProcessingEvent = false;
    }
  }

  Future<void> _handleSignEvent(
      LocationEvent event, Emitter<LocationState> emit) async {
    if (_isProcessingEvent) return;
    _isProcessingEvent = true;

    try {
      if (!emit.isDone) {
        _emitLoadingState(emit);
      }

      try {
        await _validateLocationAndProcessSign(event, emit);
      } on AppError catch (e) {
        if (!emit.isDone) {
          _emitErrorState(e, emit);
        }
      }
    } finally {
      _isProcessingEvent = false;
    }
  }

  Future<void> _validateLocationAndProcessSign(
      LocationEvent event, Emitter<LocationState> emit) async {
    final authState = authBloc.state;
    if (!authState.isAuthenticated ||
        authState.token == null ||
        authState.user == null) {
      if (!emit.isDone) {
        _emitErrorState(
            const AppError('Usuario no autenticado para fichar'), emit);
      }
      return;
    }

    final currentLocation = await locationRepository.getCurrentLocation();

    if (!currentLocation.isValid()) {
      throw const ValidationError('Ubicación no válida');
    }

    final signData = _buildSignModel(event, currentLocation);

    if (kDebugMode) {
      print(
          "LocationBloc: Evento: ${event.runtimeType}, Tipo de fichaje: ${signData.type}");
    }

    final signType =
        await signServices.hadleSign(signData, authBloc, signServices);

    if (signType != null) {
      if (kDebugMode) {
        print("LocationBloc: Tipo de fichaje registrado: $signType");
      }

      if (!emit.isDone) {
        final status = {
              'E': LocationStateStatus.working,
              'DE': LocationStateStatus.working,
              'DS': LocationStateStatus.resting,
              'S': LocationStateStatus.outside,
            }[signType] ??
            LocationStateStatus.error;

        if (kDebugMode) {
          print(
              "LocationBloc: Emitiendo estado UI basado en fichaje actual: $signType -> $status");
        }

        emit(state.copyWith(
          status: status,
          currentUserLocation: currentLocation,
          errorMessage: null,
        ));
      }
    }
  }

  void _handleCancelEvent(CancelEvent event, Emitter<LocationState> emit) {
    if (!emit.isDone) {
      emit(state.copyWith(status: LocationStateStatus.outside));
    }
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

  void _emitErrorState(dynamic error, Emitter<LocationState> emit) {
    final errorMessage =
        error is AppError ? error.message : 'Error desconocido $error';

    emit(state.copyWith(
        status: LocationStateStatus.error, errorMessage: errorMessage));
  }

  void _emitLoadingState(Emitter<LocationState> emit) {
    emit(state.copyWith(status: LocationStateStatus.loading));
  }

  String _getSignTypeFromEvent(LocationEvent event) {
    final signType = switch (event) {
      InitWorkingEvent _ => 'E',
      InitRestingEvent _ => 'DS',
      ReturnWorkingEvent _ => 'DE',
      GoOutEvent _ => 'S',
      _ => 'S',
    };

    if (kDebugMode) {
      print(
          "LocationBloc: Evento ${event.runtimeType} mapeado a tipo de fichaje: $signType");
    }

    return signType;
  }

  String _getFormattedTime() => DateFormat('HH:mm:ss').format(DateTime.now());

  @override
  LocationState? fromJson(Map<String, dynamic> json) =>
      LocationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LocationState state) => state.toJson();
}
