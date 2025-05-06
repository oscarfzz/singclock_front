// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) =>
    GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  int id;
  int adminPhoneId;
  String? groupCheck;
  String? groupName;
  double? groupLat;
  double? groupLon;
  int? licenses;
  String? description;
  String? cif;
  String? address;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? email;
  int? deleted;
  // datos de la tabla group_phone relacion pivote
  int? groupPhoneId;
  String? dayType;
  String? dayForm;
  bool? restPact;
  int? restMinutes;
  bool? flex;
  bool? customCheck;
  String? customCheckForm;
  int? hoursWeek;
  int? hoursYear;

  GroupModel({
    required this.id,
    required this.adminPhoneId,
    this.groupCheck,
    this.groupName,
    this.groupLat,
    this.groupLon,
    this.licenses,
    this.description,
    this.cif,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.email,
    this.deleted,
    this.groupPhoneId,
    this.dayType,
    this.dayForm,
    this.restPact,
    this.restMinutes,
    this.flex,
    this.customCheck,
    this.customCheckForm,
    this.hoursWeek,
    this.hoursYear,
  });

  GroupModel copyWith({
    int? id,
    int? adminPhoneId,
    String? groupCheck,
    String? groupName,
    double? groupLat,
    double? groupLon,
    int? licenses,
    String? description,
    String? cif,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? email,
    int? deleted,
    int? groupPhoneId,
    String? dayType,
    String? dayForm,
    bool? restPact,
    int? restMinutes,
    bool? flex,
    bool? customCheck,
    String? customCheckForm,
    int? hoursWeek,
    int? hoursYear,
  }) =>
      GroupModel(
        id: id ?? this.id,
        adminPhoneId: adminPhoneId ?? this.adminPhoneId,
        groupCheck: groupCheck ?? this.groupCheck,
        groupName: groupName ?? this.groupName,
        groupLat: groupLat ?? this.groupLat,
        groupLon: groupLon ?? this.groupLon,
        licenses: licenses ?? this.licenses,
        description: description ?? this.description,
        cif: cif ?? this.cif,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        postalCode: postalCode ?? this.postalCode,
        email: email ?? this.email,
        deleted: deleted ?? this.deleted,
        groupPhoneId: groupPhoneId ?? this.groupPhoneId,
        dayType: dayType ?? this.dayType,
        dayForm: dayForm ?? this.dayForm,
        restPact: restPact ?? this.restPact,
        restMinutes: restMinutes ?? this.restMinutes,
        flex: flex ?? this.flex,
        customCheck: customCheck ?? this.customCheck,
        customCheckForm: customCheckForm ?? this.customCheckForm,
        hoursWeek: hoursWeek ?? this.hoursWeek,
        hoursYear: hoursYear ?? this.hoursYear,
      );

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        adminPhoneId: json["admin_phone_id"],
        groupCheck: json["group_check"],
        groupName: json["group_name"],
        groupLat: json["group_lat"]?.toDouble(),
        groupLon: json["group_lon"]?.toDouble(),
        licenses: json["licenses"],
        description: json["description"],
        cif: json["cif"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        email: json["email"],
        deleted: json["deleted"],
        // datos de la tabla group_phone relacion pivote
        groupPhoneId: json["group_phone_id"],
        dayType: json["day_type"],
        dayForm: json["day_form"],
        restPact: json["rest_pact"],
        restMinutes: json["rest_minutes"],
        flex: json["flex"],
        customCheck: json["custom_check"],
        customCheckForm: json["custom_check_form"],
        hoursWeek: json["hours_week"],
        hoursYear: json["hours_year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_phone_id": adminPhoneId,
        "group_check": groupCheck,
        "group_name": groupName,
        "group_lat": groupLat,
        "group_lon": groupLon,
        "licenses": licenses,
        "description": description,
        "cif": cif,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "email": email,
        "deleted": deleted,
        // datos de la tabla group_phone relacion pivote
        "group_phone_id": groupPhoneId,
        "day_type": dayType,
        "day_form": dayForm,
        "rest_pact": restPact,
        "rest_minutes": restMinutes,
        "flex": flex,
        "custom_check": customCheck,
        "custom_check_form": customCheckForm,
        "hours_week": hoursWeek,
        "hours_year": hoursYear,
      };
}
