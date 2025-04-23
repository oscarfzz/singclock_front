import 'package:json_annotation/json_annotation.dart';
part 'current_user_location_entity.g.dart';

@JsonSerializable()
class CurrentUserLocationEntity {
  final double latitude;
  final double longitude;

  const CurrentUserLocationEntity({
    required this.latitude,
    required this.longitude,
  });

  factory CurrentUserLocationEntity.fromJson(Map<String, double> json) =>
      _$CurrentUserLocationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserLocationEntityToJson(this);
  //static fromJson(Map<String, dynamic> json) {}
  //

  static const empty = CurrentUserLocationEntity(latitude: 0, longitude: 0);
}
