// To parse this JSON data, do
//
//     final telInfo = telInfoFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

PhoneModel phoneFromJson(String str) => PhoneModel.fromJson(json.decode(str));

String phoneToJson(PhoneModel data) => json.encode(data.toJson());

class PhoneModel extends Equatable {
  const PhoneModel({
    required this.phoneId,
    required this.phoneNumber,
    this.userName = '',
    this.type = '',
    this.password = 0,
    this.phoneCode = '',
    this.accept = false,
    this.groupPhoneId = 0,
    this.groupId = 0,
    this.groupName = '',
    this.groupCheck = '',
    this.groupLat = .0,
    this.groupLon = .0,
    this.adminPhoneId = 0,
    this.customCheck = false,
    this.customCheckForm = '',
    this.dayType = '',
    this.dayForm = '',
    this.restPact = false,
    this.restMinutes = 0,
    this.flex = false,
    this.hoursWeek = .0,
    this.hoursYear = .0,
    this.lastSign = '',
  });

  final int phoneId;
  final String phoneNumber;
  final String userName;
  final String type;
  final int password;
  final String phoneCode;
  final bool accept;
  final int groupPhoneId;
  final int groupId;
  final String groupName;
  final String groupCheck;
  final double groupLat;
  final double groupLon;
  final int adminPhoneId; //of group
  final bool customCheck;
  final String customCheckForm;
  final String dayType;
  final String dayForm;
  final bool restPact;
  final int restMinutes;
  final bool flex;
  final double hoursWeek;
  final double hoursYear;
  final String lastSign;

  PhoneModel copyWith({
    int? phoneId,
    String? phoneNumber,
    String? userName,
    String? type,
    int? password,
    String? phoneCode,
    bool? accept,
    int? groupPhoneId,
    int? groupId,
    String? groupName,
    String? groupCheck,
    double? groupLat,
    double? groupLon,
    int? adminPhoneId,
    bool? customCheck,
    String? customCheckForm,
    String? dayType,
    String? dayForm,
    bool? restPact,
    int? restMinutes,
    bool? flex,
    double? hoursWeek,
    double? hoursYear,
    String? lastSign,
  }) {
    return PhoneModel(
      phoneId: phoneId ?? this.phoneId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      phoneCode: phoneCode ?? this.phoneCode,
      accept: accept ?? this.accept,
      groupPhoneId: groupPhoneId ?? this.groupPhoneId,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      groupCheck: groupCheck ?? this.groupCheck,
      groupLat: groupLat ?? this.groupLat,
      groupLon: groupLon ?? this.groupLon,
      adminPhoneId: adminPhoneId ?? this.adminPhoneId, // of group
      type: type ?? this.type,
      customCheck: customCheck ?? this.customCheck,
      customCheckForm: customCheckForm ?? this.customCheckForm,
      dayType: dayType ?? this.dayType,
      dayForm: dayForm ?? this.dayForm,
      restPact: restPact ?? this.restPact,
      restMinutes: restMinutes ?? this.restMinutes,
      flex: flex ?? this.flex,
      hoursWeek: hoursWeek ?? this.hoursWeek,
      hoursYear: hoursYear ?? this.hoursYear,
      lastSign: lastSign ?? this.lastSign,
    );
  }

  factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(
        phoneId: json["phone_id"],
        phoneNumber: json["phone_number"],
        userName: json["user_name"] ?? '',
        type: json["type"] ?? '',
        accept: json["accept"] ? true : false,
        password: json["password"] ?? 0,
        phoneCode: json["phone_code"] ?? '',
        groupPhoneId: json["group_phone_id"] ?? 0,
        groupId: json["group_id"] ?? 0,
        groupName: json["group_name"] ?? '',
        groupCheck: json["group_check"] ?? '',
        groupLat: json["group_lat"] ?? .0,
        groupLon: json["group_lon"] ?? .0,
        adminPhoneId: json["admin_phone_id"] ?? 0,
        customCheck: json["custom_check"] ? true : false,
        customCheckForm: json["custom_check_form"] ?? '',
        dayType: json["day_type"] ?? '',
        dayForm: json["day_form"] ?? '',
        restPact: json["rest_pact"] ? true : false,
        restMinutes: json["rest_minutes"] ?? 0,
        flex: json["flex"] ? true : false,
        hoursWeek: json["hours_week"].toDouble(),
        hoursYear: json["hours_year"].toDouble(),
        lastSign: json["last_sign"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "phone_id": phoneId,
        "phone_number": phoneNumber,
        "user_name": userName,
        "type": type,
        "password": password,
        "phone_code": phoneCode,
        "accept": accept,
        "group_phone_id": groupPhoneId,
        "group_id": groupId,
        "group_name": groupName,
        "group_check": groupCheck,
        "group_lat": groupLat,
        "group_lon": groupLon,
        "admin_phone_id": adminPhoneId,
        "custom_check": customCheck,
        "custom_check_form": customCheckForm,
        "day_type": dayType,
        "day_form": dayForm,
        "rest_pact": restPact,
        "rest_minutes": restMinutes,
        "flex": flex,
        "hours_week": hoursWeek,
        "hours_year": hoursYear,
        "last_sign": lastSign,
      };

  @override
  List<Object?> get props => [
        phoneId,
        phoneNumber,
        userName,
        password,
        phoneCode,
        accept,
        groupPhoneId,
        groupId,
        groupName,
        groupCheck,
        groupLat,
        groupLon,
        adminPhoneId,
        type,
        customCheck,
        customCheckForm,
        dayType,
        dayForm,
        restPact,
        restMinutes,
        flex,
        hoursWeek,
        hoursYear,
        lastSign,
      ];

  static const empty = PhoneModel(phoneId: 0, phoneNumber: '');

  bool get isNotEmpty => this != PhoneModel.empty;

  ChatUser get toChatUser {
    return ChatUser(
      id: phoneId.toString(),
      firstName: userName,
    );
  }
}
