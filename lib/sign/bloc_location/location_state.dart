part of 'location_bloc.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
//part 'location_bloc.g.dart';

// Originalmente los estados de F son E - [SD - ED]R - S
// Working
// Resting
// Outside

enum LocationStateStatus {
  loading,

  working,
  resting,
  outside,

  error
}

@JsonSerializable()
class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStateStatus
        .loading, //estado inicial dependiente del servidor....
    LatLng? initLocation,
    CurrentUserLocationEntity? currentUserLocation,
    String? errorMessage,
  })  : currentUserLocation =
            currentUserLocation ?? CurrentUserLocationEntity.empty,
        initLocation = initLocation ?? const LatLng(51.519475, -19.37555556),
        errorMessage = errorMessage ?? '';

  // dos opciones
  factory LocationState.fromJson(Map<String, dynamic> json) =>
      _$LocationStateFromJson(json);
  //static fromJson(Map<String, dynamic> json) => _$LocationStateFromJson(json);
  Map<String, dynamic> toJson() => _$LocationStateToJson(this);

  final LocationStateStatus status;
  final CurrentUserLocationEntity currentUserLocation;
  final LatLng initLocation;
  final String errorMessage;

  @override
  List<Object> get props => [
        status,
        currentUserLocation,
        initLocation,
        errorMessage,
      ];

  LocationState copyWith({
    LocationStateStatus? status,
    CurrentUserLocationEntity? currentUserLocation,
    LatLng? initLocation,
    Location? location,
    String? errorMessage,
  }) {
    return LocationState(
      status: status ?? this.status,
      currentUserLocation: currentUserLocation ?? this.currentUserLocation,
      initLocation: initLocation ?? this.initLocation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LocationInitial extends LocationState {}

class LocationWorking extends LocationState {}

class LocationResting extends LocationState {}

class LocationOutside extends LocationState {}

// sólo para hydrated bloc contener los datos almacenados
