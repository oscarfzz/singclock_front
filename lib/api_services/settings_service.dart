import 'package:signclock/models/api_response_model.dart';

import 'api_service.dart';

import 'package:signclock/models/group_model.dart';
import 'package:signclock/models/phone_model.dart';

import 'package:signclock/constant/api_constants.dart';

class SettingsService extends ApiService {
  SettingsService(super.dio, [super.authBlocForLogout]);

  Future<ApiResponseModel<List<GroupModel>>> getGroupsList(int phoneId) async {
    return await apiRequest<List<GroupModel>>(
      endpoint: ApiConstants.getGroups,
      data: {'phone_id': phoneId},
      fromJson: (json) => json != null
          ? List<GroupModel>.from(json.map((x) => GroupModel.fromJson(x)))
          : [],
    );
  }

  Future<ApiResponseModel<bool>> updateGroup(
      GroupModel group, int groupPhoneId) async {
    return await apiRequest<bool>(
        endpoint: ApiConstants.updateGroup,
        data: {
          'group_id': group.id,
          'group_phone_id': groupPhoneId,
          'data': group.toJson(),
        },
        fromJson: (dynamic json) => json['status'] == "success");
  }

  Future<ApiResponseModel<PhoneModel?>> updateUser(PhoneModel user) async {
    return await apiRequest<PhoneModel>(
      endpoint: ApiConstants.statusInfo,
      data: {'crud': 'U', 'phone_id': user.phoneId, 'user': user.toJson()},
      fromJson: (dynamic json) => PhoneModel.fromJson(json),
    );
  }

  Future<ApiResponseModel<bool>> setGeoFence(
      int groupPhoneId, double lat, double lon, double radius) async {
    return await apiRequest(
      endpoint: ApiConstants.setGeoFence,
      data: {
        'group_phone_id': groupPhoneId,
        'lat': lat,
        'lon': lon,
        'radius': radius,
      },
      fromJson: (dynamic json) => json['status'] == "success",
    );
  }
}
