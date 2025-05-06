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
  List<MessageEntity>? datalist;
  List<DataIn>? dataIn;

  IncidenciasModel({this.success, this.datalist, this.dataIn});

  IncidenciasModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['datalist'] != null) {
      datalist = <MessageEntity>[];
      json['datalist'].forEach((v) {
        datalist!.add(MessageEntity.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class MessageEntity {
  int? idIncidencia;
  int? idNumero;
  String? nombre;
  String? para;
  String? texto;
  String? leido;
  DateTime? datetime;

  MessageEntity(
      {this.idIncidencia,
      this.idNumero,
      this.nombre,
      this.para,
      this.texto,
      this.leido,
      this.datetime});

  MessageEntity.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
        json["datetime"] == null ? null : DateTime.parse(json["datetime"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_incidencia'] = idIncidencia;
    data['id_numero'] = idNumero;
    data['texto'] = texto;
    data['leido'] = leido;
    data['datetime'] = datetime?.toIso8601String();
    return data;
  }
}
