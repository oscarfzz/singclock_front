import 'package:signclock/sign/location_repo/current_user_location_entity.dart';

extension CurrentUserLocationValidation on CurrentUserLocationEntity {
  bool isValid() {
    return latitude != null &&
           longitude != null &&
           latitude >= -90.0 &&
           latitude <= 90.0 &&
           longitude >= -180.0 &&
           longitude <= 180.0;
  }
}