// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

List<ChatListModel> chatListModelFromJson(String str) =>
    List<ChatListModel>.from(
        json.decode(str).map((x) => ChatListModel.fromJson(x)));

String chatListModelToJson(List<ChatListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatListModel {
  ChatListModel({
    required this.idIncidencia,
    required this.idNumero,
    required this.nombre,
    required this.para,
    required this.texto,
    required this.leido,
    required this.datetime,
  });

  String idIncidencia;
  String idNumero;
  String nombre;
  String para;
  String texto;
  String leido;
  DateTime datetime;

  ChatListModel copyWith({
    String? idIncidencia,
    String? idNumero,
    String? nombre,
    String? para,
    String? texto,
    String? leido,
    DateTime? datetime,
  }) =>
      ChatListModel(
        idIncidencia: idIncidencia ?? this.idIncidencia,
        idNumero: idNumero ?? this.idNumero,
        nombre: nombre ?? this.nombre,
        para: para ?? this.para,
        texto: texto ?? this.texto,
        leido: leido ?? this.leido,
        datetime: datetime ?? this.datetime,
      );

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        idIncidencia: json["id_incidencia"] ?? "",
        idNumero: json["id_numero"] ?? "",
        nombre: json["nombre"] ?? "",
        para: json["para"] ?? "",
        texto: json["texto"] ?? "",
        leido: json["leido"] ?? "",
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "id_incidencia": idIncidencia,
        "id_numero": idNumero,
        "nombre": nombre,
        "para": para,
        "texto": texto,
        "leido": leido,
        "datetime": datetime.toIso8601String(),
      };
}
