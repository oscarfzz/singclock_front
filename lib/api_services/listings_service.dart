import 'package:signclock/api_services/api_service.dart';

import 'package:signclock/models/api_response_model.dart';
import 'package:signclock/models/phone_model.dart';
import 'package:signclock/models/regfi_model.dart';

import 'package:signclock/constant/api_constants.dart';

class ListingService extends ApiService {
  ListingService(super.dio, [super.authBlocForLogout]);

  Future<ApiResponseModel<List<RegFiModel>>> getRegs(
    PhoneModel phoneModel,
  ) async {
    return await apiRequest<List<RegFiModel>>(
      endpoint: ApiConstants.signList,
      data: phoneModel.toJson(),
      fromJson: (dynamic json) {
        if (json is List) {
          try {
            return List<RegFiModel>.from(
              json.map((x) {
                if (x is Map<String, dynamic>) {
                  return RegFiModel.fromJson(x);
                } else {
                  throw FormatException(
                    "Elemento inválido en la lista de fichajes: $x",
                  );
                }
              }),
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
