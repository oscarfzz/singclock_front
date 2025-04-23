// To parse this JSON data, do
//
//     final telInfo = telInfoFromJson(jsonString);

import 'dart:convert';

TelinfoModel telInfoFromJson(String str) =>
    TelinfoModel.fromJson(json.decode(str));

String telInfoToJson(TelinfoModel data) => json.encode(data.toJson());

class TelinfoModel {
  TelinfoModel({
    required this.success,
    required this.myId,
    required this.myNum,
    this.myName = '',
    this.contrasenia,
    this.codeVSms = '',
    this.myCode = '',
    this.acepta,
    this.myGrpCheck,
    this.myGrpLat,
    this.myGrpLon,
    this.myGrpAdminId = 0,
    this.myTip = '',
    this.checkPropio,
    this.tipoJornada,
    this.formaJornada,
    this.pactohoras,
    this.flex,
    this.descanso,
    this.minutos,
    this.semanales,
    this.anuales,
    this.myGrpId = 0,
    this.myGrpName = '',
    this.ngrupos = '',
    this.incidencias = '',
    this.ultimoF,
  });

  int success;
  int myId;
  String myNum;
  String myName;
  dynamic contrasenia;
  String codeVSms;
  String myCode;
  dynamic acepta;
  dynamic myGrpCheck;
  dynamic myGrpLat;
  dynamic myGrpLon;
  int myGrpAdminId;
  String myTip;
  dynamic checkPropio;
  dynamic tipoJornada;
  dynamic formaJornada;
  dynamic pactohoras;
  dynamic flex;
  dynamic descanso;
  dynamic minutos;
  dynamic semanales;
  dynamic anuales;
  int myGrpId;
  String myGrpName;
  String ngrupos;
  String incidencias;
  dynamic ultimoF;

  factory TelinfoModel.fromJson(Map<String, dynamic> json) => TelinfoModel(
        success: json["success"] ?? 0,
        myId: json["myId"] ?? 0,
        myNum: json["myNum"] ?? '',
        myName: json["myName"] ?? '',
        contrasenia: json["contrasenia"] ?? '',
        codeVSms: json["code_v_sms"] ?? '', //en desuso
        myCode: json["myCode"] ?? '',
        acepta: json["acepta"] ?? '',
        myGrpCheck: json["myGrpCheck"] ?? '',
        myGrpLat: json["myGrpLat"] ?? '',
        myGrpLon: json["myGrpLon"] ?? '',
        myGrpAdminId: json["myGrpAdminId"] ?? 0,
        myTip: json["myTip"] ?? '',
        checkPropio: json["check_propio"] ?? '',
        tipoJornada: json["tipo_jornada"] ?? '',
        formaJornada: json["forma_jornada"] ?? '',
        pactohoras: json["pactohoras"] ?? '0',
        flex: json["flex"] ?? '0',
        descanso: json["descanso"] ?? '0',
        minutos: json["minutos"] ?? '',
        semanales: json["semanales"] ?? '0',
        anuales: json["anuales"] ?? '0',
        myGrpId: json["myGrpId"] ?? 0,
        myGrpName: json["myGrpName"] ?? '',
        ngrupos: json["ngrupos"] ?? '0',
        incidencias: json["incidencias"] ?? '0',
        ultimoF: json["ultimo_F"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "myId": myId,
        "myNum": myNum,
        "myName": myName,
        "contrasenia": contrasenia,
        "code_v_sms": codeVSms,
        "myCode": myCode,
        "acepta": acepta,
        "myGrpCheck": myGrpCheck,
        "myGrpLat": myGrpLat,
        "myGrpLon": myGrpLon,
        "myGrpAdminId": myGrpAdminId,
        "myTip": myTip,
        "check_propio": checkPropio,
        "tipo_jornada": tipoJornada,
        "forma_jornada": formaJornada,
        "pactohoras": pactohoras,
        "flex": flex,
        "descanso": descanso,
        "minutos": minutos,
        "semanales": semanales,
        "anuales": anuales,
        "myGrpId": myGrpId,
        "myGrpName": myGrpName,
        "ngrupos": ngrupos,
        "incidencias": incidencias,
        "ultimo_F": ultimoF,
      };
}
