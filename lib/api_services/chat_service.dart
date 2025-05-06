import 'api_service.dart';

import 'package:signclock/chats/model/chat_model.dart';

import 'package:signclock/models/api_response_model.dart';
import 'package:signclock/models/phone_model.dart';

import 'package:signclock/constant/api_constants.dart';

class ChatService extends ApiService {
  ChatService(super.authBloc);

  Future<ApiResponseModel<ChatModel?>> createChat(
      int phoneId, String chatName) async {
    return await apiRequest<ChatModel?>(
        endpoint: ApiConstants.chat,
        data: {'crud': 'C', 'phone_id': phoneId, 'chat_name': chatName},
        fromJson: (json) {
          // print(json.toString());
          return json != null ? ChatModel.fromJson(json) : null;
        });
  }

  Future<ApiResponseModel<List<ChatModel>>> getChats(PhoneModel user) async {
    return await apiRequest<List<ChatModel>>(
      endpoint: ApiConstants.chat,
      data: {'crud': 'R', 'phone_id': user.phoneId},
      fromJson: (json) =>
          (json is List) ? json.map((x) => ChatModel.fromJson(x)).toList() : [],
    );
  }

  Future<ApiResponseModel<ChatModel?>> getSingleChat(
      int chatId, PhoneModel user, String token) async {
    return await apiRequest<ChatModel?>(
      endpoint: ApiConstants.message,
      data: {'crud': 'R', 'chat_id': chatId, 'phone_id': user.phoneId},
      fromJson: (json) => json != null ? ChatModel.fromJson(json) : null,
    );
  }

  Future<ApiResponseModel<ChatModel?>> addUserToChat(
      int chatId, String addPhoneNumber, PhoneModel user) async {
    return await apiRequest<ChatModel?>(
      endpoint: ApiConstants.chat,
      data: {
        'crud': 'U',
        'chat_id': chatId,
        'phone_id': user.phoneId,
        'add_phone_number': addPhoneNumber
      },
      fromJson: (json) => json != null ? ChatModel.fromJson(json) : null,
    );
  }
  // De momento no se crean grupos
  // Future<ApiResponseModel<GroupModel?>> createGroup(
  //     GroupModel group, int phoneId, String token) async {
  //   return await ApiService.apiRequest<GroupModel?>(
  //     endpoint: ApiConstants.group,
  //     data: {'phone_id': phoneId, 'name': group.toJson()},
  //     headers: {'x-token': token},
  //     fromJson: (json) => json != null ? GroupModel.fromJson(json) : null,

  //   );
  // }
}
