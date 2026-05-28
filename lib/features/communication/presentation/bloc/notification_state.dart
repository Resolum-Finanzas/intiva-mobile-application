import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';

/// Base class for all states emitted by [NotificationBloc].
sealed class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}
class NotificationSuccess extends NotificationState {
  final String message;

  /// Creates a [NotificationSuccess] state.
  NotificationSuccess(this.message);
}

/// Emitted when an operation fails.
class NotificationError extends NotificationState {

  final String message;

  /// Creates a [NotificationError] state.
  NotificationError(this.message);
}

/// Emitted when the notification list has been loaded successfully.
class NotificationsLoaded extends NotificationState {

  final List<Notification> notifications;

  /// Creates a [NotificationsLoaded] state.
  NotificationsLoaded(this.notifications);
}
