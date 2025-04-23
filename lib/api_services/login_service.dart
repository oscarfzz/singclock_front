import 'package:signclock/model/api_response_model.dart';

import 'api_service.dart';

import 'package:signclock/constant/api_constants.dart';

class LoginService extends ApiService {
  LoginService(super.authBloc);

  Future<ApiResponseModel<Map<String, dynamic>>> login(
      String phoneNumber, int phoneCode) async {
    return await apiRequest<Map<String, dynamic>>(
        endpoint: ApiConstants.login,
        data: {"phone_number": phoneNumber, "phone_code": phoneCode},
        tokenHeader: false,
        fromJson: (json) => json as Map<String, dynamic>);
  }

  // si hay header['X-Token'] se agrega el token a los headers
  Future<ApiResponseModel<Map<String, dynamic>>> otp(
      String phoneNumber, String otpCode) async {
    return await apiRequest<Map<String, dynamic>>(
        endpoint: ApiConstants.otp,
        data: {"phone_number": phoneNumber, "phone_code": otpCode},
        tokenHeader: false,
        fromJson: (json) => json as Map<String, dynamic>);
  }
}
