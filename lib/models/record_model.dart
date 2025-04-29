// To parse this JSON data, do
//
//     final recordModel = recordModelFromJson(jsonString);

import 'dart:convert';

List<RecordModel> recordModelListFromJson(String str) => List<RecordModel>.from(
    json.decode(str).map((x) => RecordModel.fromJson(x)));

String recordModelListToJson(List<RecordModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

RecordModel recordModelFromJson(String str) =>
    RecordModel.fromJson(json.decode(str));

String recordModelToJson(RecordModel data) => json.encode(data.toJson());

class RecordModel {
  RecordModel({
    required this.idNumero,
    required this.idGrupo,
    DateTime? date,
    DateTime? time,
    //this.date = DateTime.parse('0000-00-00'),
    //this.time = DateTime.utc(0000, 00, 00),
    this.lat = 0,
    this.lon = 0,
    this.validado = 1,
    this.tipo = '',
  })  : date = date ?? DateTime.now(),
        time = time ?? DateTime.now();

  int idNumero;
  int idGrupo;
  DateTime date;
  DateTime time;
  double lat;
  double lon;
  int validado;
  String tipo;

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        idNumero: json["id_numero"],
        idGrupo: json["id_grupo"],
        date: DateTime.parse(json["date"]), //No me convence !!
        time: DateTime.parse(json["time"]), //No me convence !!
        lat: json["lat"],
        lon: json["lon"],
        validado: json["validado"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id_numero": idNumero,
        "id_grupo": idGrupo,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time":
            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}",
        "lat": lat,
        "lon": lon,
        "validado": validado,
        "tipo": tipo,
      };
}
