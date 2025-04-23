import 'package:location/location.dart';
import 'package:signclock/sign/location_repo/current_user_location_entity.dart';

import 'location_utils.dart';

class LocationRepository {
  final Location _location;

  LocationRepository({
    Location? location,
  }) : _location = location ?? Location();

  Future<CurrentUserLocationEntity> getCurrentLocation() async {
  final serviceEnabled = await _location.serviceEnabled();
  print("Servicio habilitado: $serviceEnabled");
  
  if (!serviceEnabled) {
    final isEnabled = await _location.requestService();
    print("Intento de habilitar servicio: $isEnabled");
    if (!isEnabled) {
      throw CurrentLocationFailure(
        error: "No está el servicio de localización activo",
      );
    }
  }

  final permissionStatus = await _location.hasPermission();
  print("Estado de permisos: $permissionStatus");
  
  if (permissionStatus == PermissionStatus.denied) {
    final status = await _location.requestPermission();
    print("Intento de conceder permisos: $status");
    if (status != PermissionStatus.granted) {
      throw CurrentLocationFailure(
        error: "No tienes todos los permisos concedidos"
            "Necesitas activarlos manualmente.",
      );
    }
  }

  // Obtener la ubicación
  late final LocationData locationData;
  try {
    locationData = await _location.getLocation();
    print("Datos de ubicación obtenidos: $locationData");
  } catch (e) {
    print("Error al obtener ubicación: $e");
    throw CurrentLocationFailure(
      error: 'Algo salió mal al obtener tu ubicación, '
          'Por favor, inténtelo de nuevo más tarde',
    );
  }

  final latitude = locationData.latitude;
  final longitude = locationData.longitude;
  final timeStamp = locationData.time;

  if (latitude == null || longitude == null || timeStamp == null) {
    throw CurrentLocationFailure(
      error: 'Algo salió mal al obtener tu ubicación, '
          'Por favor, inténtelo de nuevo',
    );
  }

  return CurrentUserLocationEntity(
    latitude: latitude,
    longitude: longitude,
  );
}

}
