import 'package:signclock/api_services/api_service.dart';

import 'package:signclock/model/api_response_model.dart';
import 'package:signclock/model/phone_model.dart';
import 'package:signclock/model/regfi_model.dart';

import 'package:signclock/constant/api_constants.dart';
import 'package:flutter/foundation.dart';

class ListingService extends ApiService {
  ListingService(super.authBloc);

  Future<ApiResponseModel<List<RegFiModel>>> getRegs(
      PhoneModel phoneModel) async {
    return await apiRequest<List<RegFiModel>>(
      endpoint: ApiConstants.signList,
      data: {
        "phone_id": phoneModel.phoneId,
        "group_phone_id": phoneModel.groupPhoneId
      },
      fromJson: (dynamic json) { 
        if (json is List) {
          try {
            return List<RegFiModel>.from(
              json.map((x) {
                 if (x is Map<String, dynamic>) {
                    return RegFiModel.fromJson(x);
                 } else {
                    throw FormatException("Elemento inválido en la lista de fichajes: $x");
                 }
              })
            );
          } catch (e) {
             return <RegFiModel>[];
          }
        } else if (json == null) {
          return <RegFiModel>[]; 
        } else {
          return <RegFiModel>[]; 
        }
      },
    );
  }
}
