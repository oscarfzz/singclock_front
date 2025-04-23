// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      chatId: (json['chat_id'] as num).toInt(),
      name: json['name'] as String?,
      createdBy: (json['created_by'] as num).toInt(),
      isPrivate: json['is_private'] as bool,
      createdAt: json['created_at'] as String,
      notReaded: (json['not_readed'] as num).toInt(),
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'name': instance.name,
      'created_by': instance.createdBy,
      'is_private': instance.isPrivate,
      'created_at': instance.createdAt,
      'not_readed': instance.notReaded,
    };
