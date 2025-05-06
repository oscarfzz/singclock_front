// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chat_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateChatMessageRequestImpl _$$CreateChatMessageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateChatMessageRequestImpl(
      chatId: (json['chatId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      crud: json['crud'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$CreateChatMessageRequestImplToJson(
        _$CreateChatMessageRequestImpl instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'userId': instance.userId,
      'crud': instance.crud,
      'message': instance.message,
    };
