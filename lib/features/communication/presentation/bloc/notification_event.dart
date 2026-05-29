abstract class NotificationEvent {}

class SendSimulationReport extends NotificationEvent {
  final String simulationId;
  final String recipientEmail;

  SendSimulationReport({
    required this.simulationId,
    required this.recipientEmail,
  });
}

class SendPaymentReminder extends NotificationEvent {
  final String simulationId;
  final int userId;

  SendPaymentReminder({
    required this.simulationId,
    required this.userId,
  });
}

class LoadNotifications extends NotificationEvent {
  final int userId;

  LoadNotifications(this.userId);
}
