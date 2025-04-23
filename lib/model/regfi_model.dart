// To parse this JSON data, do
//
//     final regFiModel = regFiModelFromJson(jsonString);

import 'dart:convert';

List<RegFiModel> regFiModelFromJson(String str) =>
    List<RegFiModel>.from(json.decode(str).map((x) => RegFiModel.fromJson(x)));

String regFiModelToJson(List<RegFiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegFiModel {
  int regId;
  int groupPhoneId;
  DateTime currentdate;
  String currenttime;
  double lat;
  double lon;
  DateTime timestamp;
  bool validated;
  String elapsedTime;
  String type;

  RegFiModel({
    required this.regId,
    required this.groupPhoneId,
    required this.currentdate,
    required this.currenttime,
    required this.lat,
    required this.lon,
    required this.timestamp,
    required this.validated,
    required this.elapsedTime,
    required this.type,
  });

  factory RegFiModel.fromJson(Map<String, dynamic> json) => RegFiModel(
        regId: json["reg_id"],
        groupPhoneId: json["group_phone_id"],
        currentdate: DateTime.parse(json["currentdate"]),
        currenttime: json["currenttime"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timestamp: DateTime.parse(json["timestamp"]),
        validated: json["validated"],
        elapsedTime: json["elapsed_time"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "reg_id": regId,
        "group_phone_id": groupPhoneId,
        // "currentdate": "${currentdate.year.toString().padLeft(4, '0')}-${currentdate.month.toString().padLeft(2, '0')}-${currentdate.day.toString().padLeft(2, '0')}",
        "currentdate": currentdate,
        "currenttime": currenttime,
        "lat": lat,
        "lon": lon,
        // "timestamp": timestamp.toIso8601String(),
        "timestamp": timestamp,
        "validated": validated,
        "elapsed_time": elapsedTime,
        "type": type,
      };
}
