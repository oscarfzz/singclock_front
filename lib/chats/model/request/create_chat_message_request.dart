import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chat_message_request.freezed.dart';
part 'create_chat_message_request.g.dart';

@freezed
class CreateChatMessageRequest with _$CreateChatMessageRequest {
  factory CreateChatMessageRequest({
    @JsonKey(name: "chat_id") required int chatId,
    @JsonKey(name: "user_id") required int userId,
    required String crud,
    required String message,
  }) = _CreateChatMessageRequest;

  factory CreateChatMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChatMessageRequestFromJson(json);
}
