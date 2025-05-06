// To parse this JSON data, do
//
//     final signModel = signModelFromJson(jsonString);

import 'dart:convert';

SignModel signModelFromJson(String str) => SignModel.fromJson(json.decode(str));

String signModelToJson(SignModel data) => json.encode(data.toJson());

class SignModel {
  dynamic groupPhoneId;
  bool? validated;
  double? lat;
  double? lon;
  String? currenttime;
  DateTime? currentdate;
  dynamic type;

  SignModel({
    this.groupPhoneId,
    this.validated,
    this.lat,
    this.lon,
    this.currenttime,
    this.currentdate,
    this.type,
  });

  SignModel copyWith({
    dynamic groupPhoneId,
    bool? validated,
    double? lat,
    double? lon,
    String? currenttime,
    DateTime? currentdate,
    dynamic type,
  }) =>
      SignModel(
        groupPhoneId: groupPhoneId ?? this.groupPhoneId,
        validated: validated ?? this.validated,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        currenttime: currenttime ?? this.currenttime,
        currentdate: currentdate ?? this.currentdate,
        type: type ?? this.type,
      );

  factory SignModel.fromJson(Map<String, dynamic> json) => SignModel(
        groupPhoneId: json["group_phone_id"],
        validated: json["validated"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        currenttime: json["currenttime"],
        currentdate: json["currentdate"] == null
            ? null
            : DateTime.parse(json["currentdate"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "group_phone_id": groupPhoneId,
        "validated": validated,
        "lat": lat,
        "lon": lon,
        "currenttime": currenttime,
        "currentdate":
            "${currentdate!.year.toString().padLeft(4, '0')}-${currentdate!.month.toString().padLeft(2, '0')}-${currentdate!.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}
