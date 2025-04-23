import 'package:signclock/api_services/api_service.dart';

import 'package:signclock/model/api_response_model.dart';
import 'package:signclock/model/phone_model.dart';
import 'package:signclock/model/regfi_model.dart';

import 'package:signclock/constant/api_constants.dart';

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
      fromJson: (json) => (json is List) 
        ? json.map((x) => RegFiModel.fromJson(x)).toList() 
        : [],
      // fromJson: (dynamic json) {
      //   // Si json es null o no es una lista, retornar lista vacía
      //   if (json == null || json is! List) {
      //     return [];
      //   }
      //   // Si es una lista, procesar normalmente
      //   return List<RegFiModel>.from(json.map((x) => RegFiModel.fromJson(x)));
      // },
    );
  }
}
