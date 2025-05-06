import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class ApiResponseModel<T> extends Equatable {
  // Estado de éxito o fallo
  final String status;

  // Mensaje de la respuesta
  final String msg;

  // Datos de la respuesta
  final T? data;

  // Token de autenticación
  final String? token;

  const ApiResponseModel._({
    required this.status,
    required this.msg,
    this.token,
    this.data,
  });

  factory ApiResponseModel({
    required String status,
    required String msg,
    String? token,
    T? data,
  }) {
    return ApiResponseModel._(
      status: status,
      msg: msg,
      token: token,
      data: data,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      msg,
      token,
      data,
    ];
  }

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$ApiResponseModelFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(
    Object? Function(T? value) toJsonT,
  ) {
    return _$ApiResponseModelToJson(this, toJsonT);
  }

  @override
  bool get stringify => true;
}
