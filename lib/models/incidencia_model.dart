// To parse this JSON data, do
//
//     final incidenciasModel = incidenciasModelFromJson(jsonString);

import 'package:meta/meta.dart';
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
        datalist!.add(new Datalist.fromJson(v));
      });
    }
    if (json['data_in'] != null) {
      dataIn = <DataIn>[];
      json['data_in'].forEach((v) {
        dataIn!.add(new DataIn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.datalist != null) {
      data['datalist'] = this.datalist!.map((v) => v.toJson()).toList();
    }
    if (this.dataIn != null) {
      data['data_in'] = this.dataIn!.map((v) => v.toJson()).toList();
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
        json["datetime"] == null ? null : DateTime.parse(json["datetime"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_incidencia'] = this.idIncidencia;
    data['id_numero'] = this.idNumero;
    data['nombre'] = this.nombre;
    data['para'] = this.para;
    data['texto'] = this.texto;
    data['leido'] = this.leido;
    data['datetime'] =
        this.datetime == null ? null : datetime!.toIso8601String();
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
        json["datetime"] == null ? null : DateTime.parse(json["datetime"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_incidencia'] = this.idIncidencia;
    data['id_numero'] = this.idNumero;
    data['texto'] = this.texto;
    data['leido'] = this.leido;
    data['datetime'] =
        this.datetime == null ? null : datetime?.toIso8601String();
    return data;
  }
}
