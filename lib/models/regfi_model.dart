// To parse this JSON data, do
//
//     final regFi = regFiFromJson(jsonString);

import 'dart:convert';

RegFi regFiFromJson(String str) => RegFi.fromJson(json.decode(str));

String regFiToJson(RegFi data) => json.encode(data.toJson());

class RegFi {
  RegFi({
    this.success = '200',
    required this.datalist,
  });

  String success;
  List<Datalist> datalist;

  factory RegFi.fromJson(Map<String, dynamic> json) => RegFi(
        success: json["success"],
        datalist: List<Datalist>.from(
            json["datalist"].map((x) => Datalist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "datalist": List<dynamic>.from(datalist.map((x) => x.toJson())),
      };
}

class Datalist {
  Datalist({
    required this.idReg,
    required this.idNumero,
    required this.currentdate,
    required this.currenttime,
    required this.lat,
    required this.lon,
    required this.time,
    required this.validado,
    required this.tiempo,
    required this.tipo,
  });

  String idReg;
  String idNumero;
  String currentdate;
  String currenttime;
  String lat;
  String lon;
  String time;
  String validado;
  String tiempo;
  String tipo;

  factory Datalist.fromJson(Map<String, dynamic> json) => Datalist(
        idReg: json["id_reg"],
        idNumero: json["id_numero"],
        currentdate: json["currentdate"], //DateTime.parse(json["currentdate"]),
        currenttime: json["currenttime"], //DateTime.parse(json["currenttime"]),
        lat: json["lat"],
        lon: json["lon"],
        time: json["time"], //DateTime.parse(json["time"]),
        validado: json["validado"],
        tiempo: json["tiempo"].toString(),
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id_reg": idReg,
        "id_numero": idNumero,
        "currentdate": currentdate,
//            "${currentdate.year.toString().padLeft(4, '0')}-${currentdate.month.toString().padLeft(2, '0')}-${currentdate.day.toString().padLeft(2, '0')}",
        //"currenttime": currenttime,
        "currenttime": currenttime,
//            "${currenttime.hour.toString().padLeft(2, '0')}:${currenttime.minute.toString().padLeft(2, '0')}:${currenttime.second.toString().padLeft(2, '0')}",
        "lat": lat,
        "lon": lon,
        "time": time,
//          time.toIso8601String(),
        "validado": validado,
        "tiempo": tiempo,
        "tipo": tipo,
      };
}
