import 'package:signclock/models/api_response_model.dart';
import 'api_service.dart';
import 'package:signclock/constant/api_constants.dart';
import 'package:flutter/foundation.dart';

class LoginService extends ApiService {
  LoginService(super.authBloc);

  Future<ApiResponseModel<Map<String, dynamic>>> authenticatePhone(
      String phoneNumber) async {
    return await apiRequest<Map<String, dynamic>>(
      endpoint: ApiConstants.login,
      data: {"phone_number": phoneNumber},
      tokenHeader: false,
      fromJson: (dynamic json) {
        if (json is Map) {
          return Map<String, dynamic>.from(
              json.map((key, value) => MapEntry(key.toString(), value)));
        } else if (json == null) {
          return <String, dynamic>{};
        } else {
          if (kDebugMode) {
            print(
                "ERROR: Expected Map or null for authenticatePhone 'data' field, got ${json.runtimeType}: $json");
          }
          return <String, dynamic>{};
        }
      },
    );
  }

  Future<ApiResponseModel<Map<String, dynamic>>> otp(
      String phoneNumber, String otpCode) async {
    return await apiRequest<Map<String, dynamic>>(
      endpoint: ApiConstants.otp,
      data: {"phone_number": phoneNumber, "phone_code": otpCode},
      tokenHeader: false,
      fromJson: (dynamic json) {
        if (json is Map) {
          return Map<String, dynamic>.from(
              json.map((key, value) => MapEntry(key.toString(), value)));
        } else if (json == null) {
          return <String, dynamic>{};
        }
        if (kDebugMode) {
          print(
              "ERROR: Expected Map for otp 'data' field, got ${json.runtimeType}: $json");
        }
        throw FormatException("Respuesta JSON inesperada para OTP: $json");
      },
    );
  }
}
