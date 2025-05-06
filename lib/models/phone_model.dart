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

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    // Helper function to safely convert to double
    double safeDouble(dynamic value) {
       if (value is double) return value;
       if (value is int) return value.toDouble();
       if (value is String) return double.tryParse(value) ?? 0.0;
       return 0.0; // Default value
    }
    // Helper function to safely convert to int
    int safeInt(dynamic value) {
       if (value is int) return value;
       if (value is double) return value.toInt();
       if (value is String) return int.tryParse(value) ?? 0;
       return 0; // Default value
    }
     // Helper function to safely convert to bool
    bool safeBool(dynamic value) {
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) {
        final lower = value.toLowerCase();
        return lower == 'true' || lower == '1';
      }
      return false; // Default value
    }

    return PhoneModel(
        phoneId: safeInt(json["phone_id"]),
        phoneNumber: json["phone_number"]?.toString() ?? '',
        userName: json["user_name"]?.toString() ?? '',
        type: json["type"]?.toString() ?? '',
        accept: safeBool(json["accept"]),
        password: safeInt(json["password"]),
        phoneCode: json["phone_code"]?.toString() ?? '',
        groupPhoneId: safeInt(json["group_phone_id"]),
        groupId: safeInt(json["group_id"]),
        groupName: json["group_name"]?.toString() ?? '',
        groupCheck: json["group_check"]?.toString() ?? '',
        groupLat: safeDouble(json["group_lat"]),
        groupLon: safeDouble(json["group_lon"]),
        adminPhoneId: safeInt(json["admin_phone_id"]),
        customCheck: safeBool(json["custom_check"]),
        customCheckForm: json["custom_check_form"]?.toString() ?? '',
        dayType: json["day_type"]?.toString() ?? '',
        dayForm: json["day_form"]?.toString() ?? '',
        restPact: safeBool(json["rest_pact"]),
        restMinutes: safeInt(json["rest_minutes"]),
        flex: safeBool(json["flex"]),
        hoursWeek: safeDouble(json["hours_week"]),
        hoursYear: safeDouble(json["hours_year"]),
        lastSign: json["last_sign"]?.toString() ?? '',
      );
  }

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
