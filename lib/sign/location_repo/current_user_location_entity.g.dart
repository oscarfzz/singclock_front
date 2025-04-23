// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_location_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUserLocationEntity _$CurrentUserLocationEntityFromJson(
        Map<String, dynamic> json) =>
    CurrentUserLocationEntity(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentUserLocationEntityToJson(
        CurrentUserLocationEntity instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
