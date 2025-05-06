import 'package:flutter/foundation.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/models/phone_model.dart';
import 'package:signclock/sign/services/app_error.dart';

import 'api_service.dart';

import 'package:signclock/models/api_response_model.dart';
import 'package:signclock/models/sign_model.dart';

import 'package:signclock/constant/api_constants.dart';

class SignServices extends ApiService {
  SignServices(super.authBloc);

  Future<ApiResponseModel<SignModel?>> postSign(SignModel signModel) async {
    return await apiRequest<SignModel?>(
      endpoint: ApiConstants.sign,
      data: signModel.toJson(),
      fromJson: (dynamic json) =>
          json != null ? SignModel.fromJson(json) : null,
    );
  }

  Future<ApiResponseModel<List<dynamic>?>> getSignList(
      PhoneModel phoneModel) async {
    return await apiRequest<List<dynamic>?>(
      endpoint: ApiConstants.signList,
      data: phoneModel.toJson(),
      fromJson: (dynamic json) {
        if (json is List) {
          return json;
        } else if (json is Map &&
            json.containsKey('data') &&
            json['data'] is List) {
          return json['data'] as List<dynamic>;
        } else if (json == null) {
          return null;
        }
        if (kDebugMode) {
          print(
              "WARN: Expected List or Map with 'data' key for getSignList, got ${json.runtimeType}");
        }
        return null;
      },
    );
  }

  Future<String?> hadleSign(
      SignModel data, AuthHyBloc authBloc, SignServices signServices) async {
    if (kDebugMode) {
      print("SignServices: Enviando fichaje de tipo: ${data.type}");
    }

    var retData = await signServices.postSign(data);

    if (kDebugMode) {
      print(
          "SignServices: Respuesta de API para fichaje: status=${retData.status}, tipo=${retData.data?.type}");
    }

    if (retData.status == "success") {
      authBloc.add(UserUpdated(
        lastSign: retData.data!.type,
      ));

      return retData.data!.type;
    } else {
      throw NetworkError(retData.msg);
    }
  }

  Future<ApiResponseModel<Map<String, dynamic>?>> getActualStatus(
      PhoneModel phoneModel) async {
    return await apiRequest<Map<String, dynamic>?>(
      endpoint: ApiConstants.statusInfo,
      data: phoneModel.toJson(),
      fromJson: (dynamic json) {
        if (json is Map) {
          return Map<String, dynamic>.from(
              json.map((key, value) => MapEntry(key.toString(), value)));
        } else if (json == null) {
          return null;
        }
        if (kDebugMode) {
          print(
              "WARN: Expected Map or null in fromJson for getActualStatus, got ${json.runtimeType}");
        }
        return null;
      },
    );
  }
}
