// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatParticipantEntityImpl _$$ChatParticipantEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatParticipantEntityImpl(
      id: (json['id'] as num).toInt(),
      idGrp: (json['chat_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatParticipantEntityImplToJson(
        _$ChatParticipantEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.idGrp,
      'user_id': instance.userId,
      'user': instance.user,
    };
