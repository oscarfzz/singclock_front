import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      print("Servicio habilitado: $serviceEnabled");
    }

    if (!serviceEnabled) {
      final isEnabled = await _location.requestService();
      if (kDebugMode) {
        print("Intento de habilitar servicio: $isEnabled");
      }
      if (!isEnabled) {
        throw CurrentLocationFailure(
          error: "No está el servicio de localización activo",
        );
      }
    }

    final permissionStatus = await _location.hasPermission();
    if (kDebugMode) {
      print("Estado de permisos: $permissionStatus");
    }

    if (permissionStatus == PermissionStatus.denied) {
      final status = await _location.requestPermission();
      if (kDebugMode) {
        print("Intento de conceder permisos: $status");
      }
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
      if (kDebugMode) {
        print("Datos de ubicación obtenidos: $locationData");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error al obtener ubicación: $e");
      }
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
