import 'package:dio/dio.dart';
import 'package:intiva_mobile_application/features/communication/data/remote/services/notification_service.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';
import 'package:intiva_mobile_application/features/communication/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _service;

  NotificationRepositoryImpl(this._service);

  @override
  Future<void> sendSimulationReport({
    required String simulationId,
    required String recipientEmail,
  }) async {
    try {
      await _service.sendSimulationReport({
        'simulationId': simulationId,
        'recipientEmail': recipientEmail,
      });
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<void> sendPaymentReminder({
    required String simulationId,
    required int userId,
  }) async {
    try {
      await _service.sendPaymentReminder({
        'simulationId': simulationId,
        'userId': userId,
      });
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<List<Notification>> getNotificationsByUser(int userId) async {
    try {
      final dtos = await _service.getNotificationsByUser(userId);
      return dtos.map((d) => d.toDomain()).toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) => switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout =>
          Exception('Connection timed out. Please try again.'),
        DioExceptionType.badResponse => switch (e.response?.statusCode) {
            404 => Exception('Resource not found.'),
            401 => Exception('Not authorised.'),
            _ => Exception('Server error: ${e.response?.statusCode}'),
          },
        _ => Exception('Network error: ${e.message}'),
      };
}
