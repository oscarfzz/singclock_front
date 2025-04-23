import 'package:intl/intl.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

import 'package:equatable/equatable.dart';
import 'package:signclock/sign/services/current_location_isValid.dart';
import 'package:signclock/api_services/sign_services.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/model/phone_model.dart';
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

  late final PhoneModel phoneModel;
  late final String token;

  LocationBloc({
    required this.locationRepository,
    required this.authBloc,
    required this.signServices,
  }) : super(const LocationState()) {
    _isAuthenticated();

    on<InitEvent>(_handleInitEvent);
    on<InitWorkingEvent>(_handleSignEvent);
    on<InitRestingEvent>(_handleSignEvent);
    on<ReturnWorkingEvent>(_handleSignEvent);
    on<GoOutEvent>(_handleSignEvent);
    on<CancelEvent>(_handleCancelEvent);
  }

  void _isAuthenticated() {
    if (authBloc.state.token == null || authBloc.state.user == null) {
      authBloc.add(const Unauthenticated());
      throw const AppError('No autenticado');
    } else {
      phoneModel = authBloc.state.user!;
      token = authBloc.state.token!;
    }
  }

  Future<void> _handleInitEvent(
      InitEvent event, Emitter<LocationState> emit) async {
    _emitLoadingState(emit);
    try {
      _emitStateFromLastSign(phoneModel.lastSign, emit);
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
    return SignModel(
      groupPhoneId: phoneModel.groupPhoneId,
      currentdate: DateTime.now(),
      currenttime: _getFormattedTime(),
      lat: currentLocation.latitude,
      lon: currentLocation.longitude,
      validated: true,
      type: _getSignTypeFromEvent(event),
    );
  }

  void _emitStateFromLastSign(String lastSign, Emitter<LocationState> emit,
      [CurrentUserLocationEntity? currentLocation]) async {
    final status = {
          'E': LocationStateStatus.working,
          'DE': LocationStateStatus.working,
          'DS': LocationStateStatus.resting,
          'S': LocationStateStatus.outside,
        }[lastSign] ??
        LocationStateStatus.error;

    emit(state.copyWith(
      status: status,
      currentUserLocation: currentLocation,
      errorMessage: status == LocationStateStatus.error ? lastSign : null,
    ));

    try {
      // Obtenemos el estado actual desde el servidor
      final apiResponse = await signServices.getActualStatus(phoneModel);

      if (apiResponse.status == "success" && apiResponse.data != null) {
        final serverStatus = {
              'E': LocationStateStatus.working,
              'DE': LocationStateStatus.working,
              'DS': LocationStateStatus.resting,
              'S': LocationStateStatus.outside,
            }[apiResponse.data!] ??
            LocationStateStatus.error;
            
        if(!emit.isDone){
        emit(state.copyWith(
          status: serverStatus,
          currentUserLocation: currentLocation,
          errorMessage: serverStatus == LocationStateStatus.error
              ? apiResponse.data!
              : null,
        ));}
      }
    } catch (error) {
      // Si ocurre un error al obtener el estado del servidor, no afecta el estado emitido inicialmente
      if(!emit.isDone){
        emit(state.copyWith(
          status: LocationStateStatus.error,
          errorMessage: 'Error al obtener estado del servidor: $error',
        ));
      }
    }
  }

  void _emitErrorState(dynamic error, Emitter<LocationState> emit) {
    final errorMessage =
        error is AppError ? error.message : 'Error desconocido $error';

    emit(state.copyWith(
        status: LocationStateStatus.error, errorMessage: errorMessage));
    addError(error);
  }

  void _emitLoadingState(Emitter<LocationState> emit) {
    emit(state.copyWith(status: LocationStateStatus.loading));
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
