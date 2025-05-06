import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class AppResponse<T> extends Equatable {
  // bool para bien o mal
  final bool success;

  // message de appResponse
  final String message;

  // app response data
  final T? data;

  // status code NO de la api
  final int statusCode;

  // status message añadido por el http response No de la API
  final String statusMessage;

  const AppResponse._({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });

  factory AppResponse({
    required bool success,
    required String message,
    int? statusCode,
    String? statusMessage,
    T? data,
  }) {
    return AppResponse._(
      success: success,
      message: message,
      statusCode: statusCode ?? 200,
      statusMessage: statusMessage ?? "La solicitud ha tenido éxito.",
      data: data,
    );
  }

  @override
  List<Object?> get props {
    return [
      success,
      message,
      data ?? "",
    ];
  }

  factory AppResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$AppResponseFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(
    Object? Function(T? value) toJsonT,
  ) {
    return _$AppResponseToJson(this, toJsonT);
  }

  @override
  bool get stringify => true;
}
