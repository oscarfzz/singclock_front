// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chat_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateChatMessageRequestImpl _$$CreateChatMessageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateChatMessageRequestImpl(
      chatId: (json['chat_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      crud: json['crud'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$CreateChatMessageRequestImplToJson(
        _$CreateChatMessageRequestImpl instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'user_id': instance.userId,
      'crud': instance.crud,
      'message': instance.message,
    };
