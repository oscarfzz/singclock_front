import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:signclock/model/api_response_model.dart';

import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';

class ApiService {
  final AuthHyBloc authBloc;
  final Dio _dio = Dio()..options.validateStatus = (status) => status! < 500;

  ApiService(this.authBloc) {
    if (kDebugMode) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Future<ApiResponseModel<T>> apiRequest<T>(
      {required String endpoint,
      required dynamic data,
      Map<String, String>? headers,
      bool tokenHeader = true,
      required T Function(dynamic json) fromJson}) async {
    try {
      if (tokenHeader) {
        final token = authBloc.state.token;
        if (token == null) throw Exception('Token no disponible');
        headers = {'X-Token': token, ...?headers};
      }

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {
          ...?headers,
          "Content-Type": "application/json",
          "Accept": "application/json"
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponseModel<T>.fromJson(
          parseResponse(response),
          fromJson,
        );
      } else if (response.statusCode == 401) {
        authBloc.add(Unauthenticated());
        return ApiResponseModel<T>.fromJson(
          handleError(("No autorizado"), response.statusCode),
          fromJson,
        );
      } else {
        return ApiResponseModel<T>.fromJson(
          handleError(
              (response.data['msg'] ?? 'Sin respuesta'), response.statusCode),
          fromJson,
        );
      }
    } on DioException catch (e) {
      return ApiResponseModel<T>.fromJson(
        handleError(e.message ?? "Error de red"),
        fromJson,
      );
    } catch (e) {
      print("Error--->: $e");
      return ApiResponseModel<T>.fromJson(
        handleError("Error desconocido $e"),
        fromJson,
      );
    }
  }

  // Método genérico para realizar solicitudes API con manejo de errores
  // Future<Map<String, dynamic>> apiRequestVOLD({
  //   required String endpoint,
  //   required dynamic data,
  //   Map<String, String>? headers,
  //   bool tokenHeader = true,
  // }) async {
  //   try {
  //     if (tokenHeader) {
  //       final token = AuthHyBloc().state.token;
  //       if (token == null) throw Exception('Token no disponible');
  //       headers = {'X-Token': token, ...?headers};
  //     }
  //     final response = await _dio.post(
  //       endpoint,
  //       data: data,
  //       options: Options(headers: {
  //         ...?headers,
  //         "Content-Type": "application/json",
  //         "Accept": "application/json"
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       return _parseResponse(response);
  //       // intentar que todo response sea "status", msg y data[]
  //     } else {
  //       return _handleError(
  //           "Error en la respuesta del servidor", response.statusCode);
  //     }
  //   } on DioException catch (e) {
  //     return _handleError(e.message ?? "Error de red");
  //   } catch (e) {
  //     return _handleError("Error desconocido");
  //   }
  // }

  // Procesa la respuesta en un formato común
  Map<String, dynamic> parseResponse(Response response) {
    final data = response.data;
    String? token = response.headers.value('x-token');
    return {
      'status': data['status'] ?? "error",
      'msg': data['msg'] ?? 'Error desconocido',
      'token': token ?? '',
      'data': data['data'] ?? {},
    };
  }

  // Función para manejar errores y generar respuesta uniforme
  Map<String, dynamic> handleError(String message, [int? statusCode]) {
    return {
      "status": "error",
      "msg": "$message ${statusCode != null ? '(code: $statusCode)' : ''}",
      "data": {}
    };
  }
}
