import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';

/// Abstract contract for the notification data source.
abstract class NotificationRepository {
  /// Sends a simulation report email to [recipientEmail] for [simulationId].
  ///
  /// Throws an [Exception] if the request fails.
  Future<void> sendSimulationReport({
    required String simulationId,
    required String recipientEmail,
  });

  /// Sends a payment reminder for [simulationId] to the user identified by [userId].
  ///
  /// Throws an [Exception] if the request fails.
  Future<void> sendPaymentReminder({
    required String simulationId,
    required int userId,
  });

  /// Returns all notifications for the user identified by [userId].
  ///
  /// Throws an [Exception] if the request fails.
  Future<List<Notification>> getNotificationsByUser(int userId);
}
