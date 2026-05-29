import 'package:intiva_mobile_application/features/communication/domain/models/notification_status.dart';

export 'notification_status.dart';

class Notification {
  final String id;
  final String emailAddress;
  final String subject;
  final String htmlContent;
  final String recipientName;
  final int relatedEntityId;
  final NotificationStatus status;
  final DateTime createdAt;

  const Notification({
    required this.id,
    required this.emailAddress,
    required this.subject,
    required this.htmlContent,
    required this.recipientName,
    required this.relatedEntityId,
    required this.status,
    required this.createdAt,
  });
}
