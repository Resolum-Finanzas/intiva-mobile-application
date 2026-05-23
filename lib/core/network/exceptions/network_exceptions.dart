import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException(this.message, {this.statusCode});

  factory NetworkException.fromDioError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout => const NetworkException(
        'No Connection.',
      ),
      DioExceptionType.receiveTimeout => const NetworkException(
        'The server took too long to respond.',
      ),
      DioExceptionType.badResponse => NetworkException(
        e.response?.data?['message'] ?? 'Server error.',
        statusCode: e.response?.statusCode,
      ),
      _ => const NetworkException('Unexpected error.'),
    };
  }
}
