part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationEvent extends LocationEvent {}

class FetchLocationEvent extends LocationEvent {}
// Eventos de cambio de estado de F
//

class InitEvent extends LocationEvent {}

class CancelEvent extends LocationEvent {}

class InitWorkingEvent extends LocationEvent {}

class InitRestingEvent extends LocationEvent {}

class ReturnWorkingEvent extends LocationEvent {}

class GoOutEvent extends LocationEvent {}
