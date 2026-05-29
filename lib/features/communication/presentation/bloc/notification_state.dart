import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';

class NotificationState {
  final Status status;
  final List<Notification> notifications;
  final String? successMessage;
  final String? message;

  const NotificationState({
    this.status = Status.initial,
    this.notifications = const [],
    this.successMessage,
    this.message,
  });

  static const _absent = Object();

  NotificationState copyWith({
    Status? status,
    List<Notification>? notifications,
    Object? successMessage = _absent,
    Object? message = _absent,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      successMessage: successMessage == _absent
          ? this.successMessage
          : successMessage as String?,
      message: message == _absent ? this.message : message as String?,
    );
  }
}
