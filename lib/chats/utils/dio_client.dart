import 'package:dio/dio.dart';
import 'package:signclock/constant/api_constants.dart';
import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';

import 'app_interceptors.dart';

class DioClient {
  late Dio _dio;
  final AuthHyBloc authBloc;

  DioClient(this.authBloc) {
    _dio = _createDioClient();
  }

  Dio get instance => _dio;

  Dio _createDioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AppInterceptors(authBloc),
    ]);

    return dio;
  }
}
