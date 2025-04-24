import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:signclock/model/api_response_model.dart';

import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';

class ApiService {
  final AuthHyBloc authBloc;
  late final Dio _dio;

  ApiService(this.authBloc) {
    final options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) => status! < 500,
      headers: {
        "Accept": "application/json",
      },
    );
    _dio = Dio(options);

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
        if (token != null) {
          headers = {'X-Token': token, ...?headers};
        }
      }

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {
          ...?headers,
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
        final String? tokenFromHeader = response.headers.value('x-token');
        
        final dynamic dataFieldContent = responseBody['data'];
        
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
                token: tokenFromHeader 
            ); 
        }

        return ApiResponseModel<T>(
            status: responseBody['status'] as String? ?? 'success',
            msg: responseBody['msg'] as String? ?? '',
            data: parsedData, 
            token: tokenFromHeader 
        );
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print("Received 401 Unauthorized. Scheduling Unauthentication event.");
        }
        Future.microtask(() {
          if (!authBloc.isClosed) {
            authBloc.add(const Unauthenticated());
          } else {
            if (kDebugMode) {
              print("AuthHyBloc was closed before Unauthenticated could be added.");
            }
          }
        });
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
          status: 'error', msg: 'Error inesperado: ${e.toString()}', data: null);
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
