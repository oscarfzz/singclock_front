// To parse this JSON data, do
//
//     final incidenciasModel = incidenciasModelFromJson(jsonString);

import 'dart:convert';

IncidenciasModel incidenciasModelFromJson(String str) =>
    IncidenciasModel.fromJson(json.decode(str));

String incidenciasModelToJson(IncidenciasModel data) =>
    json.encode(data.toJson());

class IncidenciasModel {
  String? success;
  List<Datalist>? datalist;
  List<DataIn>? dataIn;

  IncidenciasModel({this.success, this.datalist, this.dataIn});

  IncidenciasModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['datalist'] != null) {
      datalist = <Datalist>[];
      json['datalist'].forEach((v) {
        datalist!.add(Datalist.fromJson(v));
      });
    }
    if (json['data_in'] != null) {
      dataIn = <DataIn>[];
      json['data_in'].forEach((v) {
        dataIn!.add(DataIn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (datalist != null) {
      data['datalist'] = datalist!.map((v) => v.toJson()).toList();
    }
    if (dataIn != null) {
      data['data_in'] = dataIn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  String? idIncidencia;
  String? idNumero;
  String? nombre;
  String? para;
  String? texto;
  String? leido;
  DateTime? datetime;

  Datalist(
      {this.idIncidencia,
      this.idNumero,
      this.nombre,
      this.para,
      this.texto,
      this.leido,
      this.datetime});

  Datalist.fromJson(Map<String, dynamic> json) {
    idIncidencia = json['id_incidencia'];
    idNumero = json['id_numero'];
    nombre = json['nombre'];
    para = json['para'];
    texto = json['texto'];
    leido = json['leido'];
    datetime =
        json["datetime"] != null ? DateTime.parse(json["datetime"]) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_incidencia'] = idIncidencia;
    data['id_numero'] = idNumero;
    data['nombre'] = nombre;
    data['para'] = para;
    data['texto'] = texto;
    data['leido'] = leido;
    data['datetime'] = datetime?.toIso8601String();
    return data;
  }
}

class DataIn {
  String? idIncidencia;
  String? idNumero;
  String? texto;
  String? leido;
  DateTime? datetime;

  DataIn(
      {this.idIncidencia,
      this.idNumero,
      this.texto,
      this.leido,
      this.datetime});

  DataIn.fromJson(Map<String, dynamic> json) {
    idIncidencia = json['id_incidencia'];
    idNumero = json['id_numero'];
    texto = json['texto'];
    leido = json['leido'];
    datetime =
        json["datetime"] != null ? DateTime.parse(json["datetime"]) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_incidencia'] = idIncidencia;
    data['id_numero'] = idNumero;
    data['texto'] = texto;
    data['leido'] = leido;
    data['datetime'] = datetime?.toIso8601String();
    return data;
  }
}
