import 'package:signclock/api_services/api_service.dart';

import 'package:signclock/model/api_response_model.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:signclock/chats/model/request/create_chat_message_request.dart';

import 'package:signclock/constant/api_constants.dart';

class MessageService extends ApiService {
  MessageService(super.authBloc);

  Future<ApiResponseModel<ChatMessage?>> createChatMessage(
      CreateChatMessageRequest request, String socketId) async {
    return await apiRequest<ChatMessage?>(
      endpoint: ApiConstants.message,
      data: request.toJson(),
      headers: {'socket_id': socketId},
      fromJson: (json) => json != null ? ChatMessage.fromJson(json) : null,
    );
  }

  Future<ApiResponseModel<List<ChatMessage>>> getChatMessages(
      {required int chatId,
      required int page,
      required int lastMessage}) async {
    return await apiRequest<List<ChatMessage>>(
      endpoint: ApiConstants.message,
      data: {
        'chat_id': chatId,
        'page': page,
        'last_message': lastMessage,
        'crud': 'R'
      },
      fromJson: (json) => (json is List)
          ? json.map((x) => ChatMessage.fromJson(x)).toList()
          : [],
    );
  }

  Future<ApiResponseModel<bool>> createMessage(
      {required String message, required int chatId}) async {
    return await apiRequest<bool>(
      endpoint: ApiConstants.message,
      data: {'message': message, 'chat_id': chatId, 'crud': 'C'},
      //fromJson: (json) => json['status'] == 'success',
      fromJson: (json) => json,
    );
  }

  Future<ApiResponseModel<bool>> deleteChatMessage(
      {required int messageId, required int chatId}) async {
    return await apiRequest<bool>(
      endpoint: ApiConstants.message,
      data: {'message_id': messageId, 'chat_id': chatId, 'crud': 'D'},
      fromJson: (json) => json['status'] == 'success',
    );
  }
}
