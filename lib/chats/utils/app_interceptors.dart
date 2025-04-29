import 'dart:io';

import 'package:dio/dio.dart';

import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/model/app_response.dart';

class AppInterceptors extends Interceptor {
  static AppInterceptors? _singleton;

  // AppInterceptors._internal(this._authenticationRepository, this._myInfoRepo);

  // final AuthenticationRepository _authenticationRepository;
  // final MyInfoRepo _myInfoRepo;

  // factory AppInterceptors(AuthenticationRepository _authenticationRepository,
  //     MyInfoRepo _myInfoRepo) {
  //   return _singleton ??=
  //       AppInterceptors._internal(_authenticationRepository, _myInfoRepo);
  // }

  AppInterceptors._internal();

  factory AppInterceptors() {
    return _singleton ??= AppInterceptors._internal();
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
      final state = AuthHyBloc().state;
      if (state.token != null) {
        options.headers[HttpHeaders.authorizationHeader] =
            'Portadora: ${state.token}';
      }
    }

    return handler.next(options);
  }
}

@override
void onResponse(Response response, ResponseInterceptorHandler handler) {
  final responseData = mapResponseData(
    requestOptions: response.requestOptions,
    response: response,
  );

  return handler.resolve(responseData);
}

void onError(DioException err, ErrorInterceptorHandler handler) {
  // obtiene mensaje de error personalizado
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

Response<dynamic> mapResponseData({
  Response<dynamic>? response,
  required RequestOptions requestOptions,
  String customMessage = "",
  bool isErrorResponse = false,
}) {
  final bool hasResponseData = response?.data != null;

  Map<String, dynamic>? responseData = response?.data;

  if (hasResponseData) {
    responseData!.addAll({
      "statusCode": response?.statusCode,
      "statusMessage": response?.statusMessage
    });
  }

  return Response(
    requestOptions: requestOptions,
    data: hasResponseData
        ? responseData
        : AppResponse(
            success: isErrorResponse ? false : true,
            message: customMessage,
            statusCode: response?.statusCode,
            statusMessage: response?.statusMessage,
          ).toJson(
            (value) => null,
          ),
  );
}
