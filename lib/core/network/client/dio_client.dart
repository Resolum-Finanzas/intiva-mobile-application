import 'package:dio/dio.dart';
import 'package:intiva_mobile_application/core/network/api/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../interceptor/auth_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient(AuthInterceptor authInterceptor) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    ]);
  }
}
