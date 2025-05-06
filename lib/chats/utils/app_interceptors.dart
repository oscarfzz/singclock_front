import 'dart:io';

import 'package:dio/dio.dart';

import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/models/app_response.dart';

class AppInterceptors extends Interceptor {
  final AuthHyBloc authBloc;
  AppInterceptors(this.authBloc);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = authBloc.currentToken;
    if (token != null) {
      if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }
      options.headers['X-Token'] = token;
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseData = mapResponseData(
      requestOptions: response.requestOptions,
      response: response,
    );

    return handler.resolve(responseData);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMessage = getErrorMessage(err.type, err.response?.statusCode);

    final responseData = mapResponseData(
      requestOptions: err.requestOptions,
      response: err.response,
      customMessage: errorMessage,
      isErrorResponse: true,
    );

    return handler.resolve(responseData);
  }

  String getErrorMessage(DioExceptionType errorType, int? statusCode) {
    String errorMessage = "";
    switch (errorType) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = DioErrorMessage.deadlineExceededException;
        break;
      case DioExceptionType.badResponse:
        switch (statusCode) {
          case 400:
            errorMessage = DioErrorMessage.badRequestException;
            break;
          case 401:
            errorMessage = DioErrorMessage.unauthorizedException;
            break;
          case 404:
            errorMessage = DioErrorMessage.notFoundException;
            break;
          case 409:
            errorMessage = DioErrorMessage.conflictException;
            break;
          case 500:
            errorMessage = DioErrorMessage.internalServerErrorException;
            break;
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        errorMessage = DioErrorMessage.unexpectedException;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = DioErrorMessage.badCertificate;
        break;
      case DioExceptionType.connectionError:
        errorMessage = DioErrorMessage.connectionError;
        break;
    }
    return errorMessage;
  }

  Response<dynamic> mapResponseData({
    Response<dynamic>? response,
    required RequestOptions requestOptions,
    String customMessage = "",
    bool isErrorResponse = false,
  }) {
    final bool hasResponseData = response?.data != null;

    final String? tokenFromHeader = response?.headers.value('x-token');

    Map<String, dynamic>? responseData = response?.data is Map
        ? Map<String, dynamic>.from(response!.data)
        : null;

    if (hasResponseData && responseData != null) {
      if (!responseData.containsKey('status')) {
        responseData['status'] = isErrorResponse ? 'error' : 'success';
      }

      if (tokenFromHeader != null) {
        responseData['token'] = tokenFromHeader;
      }

      responseData.addAll({
        "statusCode": response?.statusCode ?? 200,
        "statusMessage": response?.statusMessage ?? "OK"
      });
    }

    final resultData = hasResponseData && responseData != null
        ? responseData
        : AppResponse(
            success: isErrorResponse ? false : true,
            message: customMessage,
            statusCode: response?.statusCode ?? 200,
            statusMessage: response?.statusMessage ?? "OK",
          ).toJson((value) => null);

    if (tokenFromHeader != null && !resultData.containsKey('token')) {
      (resultData as Map)['token'] = tokenFromHeader;
    }

    return Response(
      requestOptions: requestOptions,
      statusCode: response?.statusCode ?? 200,
      statusMessage: response?.statusMessage ?? "OK",
      headers: response?.headers ?? Headers(),
      data: resultData,
    );
  }
}

class DioErrorMessage {
  static const badRequestException = "Invalid request";
  static const internalServerErrorException =
      "Unknown error occurred, please try again later.";
  static const conflictException = "Conflict occurred";
  static const unauthorizedException = "Access denied";
  static const notFoundException =
      "The requested information could not be found";
  static const unexpectedException = "Unexpected error occurred.";
  static const noInternetConnectionException =
      "No internet connection detected, please try again.";
  static const deadlineExceededException =
      "The connection has timed out, please try again.";
  static const badCertificate = "Certifido incorrecto";
  static const connectionError = "Error de conexión";
}
