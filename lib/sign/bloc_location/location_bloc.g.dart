// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationState _$LocationStateFromJson(Map<String, dynamic> json) =>
    LocationState(
      status:
          $enumDecodeNullable(_$LocationStateStatusEnumMap, json['status']) ??
              LocationStateStatus.loading,
      initLocation: json['initLocation'] == null
          ? null
          : LatLng.fromJson(json['initLocation'] as Map<String, dynamic>),
      currentUserLocation: json['currentUserLocation'] == null
          ? null
          : CurrentUserLocationEntity.fromJson(
              (json['currentUserLocation'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            )),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$LocationStateToJson(LocationState instance) =>
    <String, dynamic>{
      'status': _$LocationStateStatusEnumMap[instance.status]!,
      'currentUserLocation': instance.currentUserLocation,
      'initLocation': instance.initLocation,
      'errorMessage': instance.errorMessage,
    };

const _$LocationStateStatusEnumMap = {
  LocationStateStatus.loading: 'loading',
  LocationStateStatus.working: 'working',
  LocationStateStatus.resting: 'resting',
  LocationStateStatus.outside: 'outside',
  LocationStateStatus.error: 'error',
};
