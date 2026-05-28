/// Base class for all events handled by [NotificationBloc].
sealed class NotificationEvent {}

/// Dispatched to send a simulation report email to [recipientEmail].
class SendSimulationReport extends NotificationEvent {

  final String simulationId;
  final String recipientEmail;

  /// Creates a [SendSimulationReport] event.
  SendSimulationReport({
    required this.simulationId,
    required this.recipientEmail,
  });
}

/// Dispatched to send a payment reminder for [simulationId] to [userId].
class SendPaymentReminder extends NotificationEvent {

  final String simulationId;
  final int userId;

  /// Creates a [SendPaymentReminder] event.
  SendPaymentReminder({required this.simulationId, required this.userId});
}

/// Dispatched to load all notifications for [userId].
class LoadNotifications extends NotificationEvent {
  /// The ID of the user whose notifications should be loaded.
  final int userId;

  /// Creates a [LoadNotifications] event.
  LoadNotifications(this.userId);
}
