import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:signclock/models/api_response_model.dart';

import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';

class ApiService {
  final Dio _dio;
  final AuthHyBloc? _authBlocForLogout;

  ApiService(this._dio, [this._authBlocForLogout]);

  Future<ApiResponseModel<T>> apiRequest<T>(
      {required String endpoint,
      required dynamic data,
      Map<String, String>? headers,
      required T Function(dynamic json) fromJson}) async {
    try {
      Map<String, String> allHeaders = {...?headers};
      if (_authBlocForLogout != null) {
        final token = _authBlocForLogout.currentToken;
        if (token != null && token.isNotEmpty) {
          allHeaders["X-Token"] = token;
        }
      }

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {
          ...allHeaders,
          "Content-Type": "application/json",
        }),
      );

      if (kDebugMode) {
        print("===== API Raw Response =====");
        print("Endpoint: $endpoint");
        print("Status Code: ${response.statusCode}");
        print("Response Headers: ${response.headers}");
        print("Response Data: ${response.data}");
        print("============================");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.data as Map<dynamic, dynamic>? ?? {};

        String? tokenFromHeader = response.headers.value('x-token');
        if (tokenFromHeader == null || tokenFromHeader.isEmpty) {
          tokenFromHeader = responseBody['token'] as String?;
        }

        final dynamic dataFieldContent = responseBody['data'];
        final String status = responseBody['status'] as String? ?? 'success';

        T parsedData;
        try {
          parsedData = fromJson(dataFieldContent);
        } catch (e, stackTrace) {
          if (kDebugMode) {
            print("===== fromJson Parsing Exception =====");
            print("Endpoint: $endpoint");
            print("Data field content type: ${dataFieldContent?.runtimeType}");
            print("Data field content: $dataFieldContent");
            print("Error: ${e.toString()}");
            print("StackTrace: $stackTrace");
            print("====================================");
          }
          return ApiResponseModel<T>(
              status: 'error',
              msg: 'Error al procesar datos de respuesta: ${e.toString()}',
              data: null,
              token: tokenFromHeader);
        }

        return ApiResponseModel<T>(
            status: status,
            msg: responseBody['msg'] as String? ?? '',
            data: parsedData,
            token: tokenFromHeader);
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print(
              "Received 401 Unauthorized. Scheduling Unauthentication event.");
        }
        if (_authBlocForLogout != null && !_authBlocForLogout.isClosed) {
          Future.microtask(() {
            _authBlocForLogout.add(const Unauthenticated());
          });
        }
        return ApiResponseModel<T>(
            status: 'error',
            msg: response.data?['msg'] ?? 'No autorizado o sesión expirada',
            data: null);
      } else {
        String errorMsg = 'Error desconocido';
        if (response.data is Map && response.data.containsKey('msg')) {
          errorMsg = response.data['msg'];
        } else if (response.data != null) {
          errorMsg = response.data.toString();
        }
        if (kDebugMode) {
          print("===== API Error Response =====");
          print("Endpoint: $endpoint");
          print("Status Code: ${response.statusCode}");
          print("Response Data: ${response.data}");
          print("=============================");
        }
        return ApiResponseModel<T>(
            status: 'error',
            msg: 'Error ${response.statusCode}: $errorMsg',
            data: null);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (_authBlocForLogout != null && !_authBlocForLogout.isClosed) {
          Future.microtask(() {
            _authBlocForLogout.add(const Unauthenticated());
          });
        }
      }
      if (kDebugMode) {
        print("===== DioException =====");
        print("Endpoint: $endpoint");
        print("Error Type: ${e.type}");
        print("Error Message: ${e.message}");
        print("Response: ${e.response?.data}");
        print("=======================");
      }
      return ApiResponseModel<T>(
          status: 'error',
          msg: 'Error de conexión (${e.type}): ${e.message}',
          data: null);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("===== General Exception =====");
        print("Endpoint: $endpoint");
        print("Error Type: ${e.runtimeType}");
        print("Error: ${e.toString()}");
        print("StackTrace: $stackTrace");
        print("============================");
      }
      return ApiResponseModel<T>(
          status: 'error',
          msg: 'Error inesperado: ${e.toString()}',
          data: null);
    }
  }

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

  Map<String, dynamic> handleError(String message, [int? statusCode]) {
    return {
      "status": "error",
      "msg": "$message ${statusCode != null ? '(code: $statusCode)' : ''}",
      "data": {}
    };
  }
}
