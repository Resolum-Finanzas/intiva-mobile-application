import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';

abstract class NotificationRepository {
  Future<void> sendSimulationReport({
    required String simulationId,
    required String recipientEmail,
  });

  Future<void> sendPaymentReminder({
    required String simulationId,
    required int userId,
  });

  Future<List<Notification>> getNotificationsByUser(int userId);
}
