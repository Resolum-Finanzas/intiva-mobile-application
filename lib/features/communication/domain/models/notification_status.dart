/// Delivery status of a [Notification].
enum NotificationStatus {

  pending,
  sent,
  failed;

  /// Returns the human-readable Spanish label for this status.
  String get label => switch (this) {
        NotificationStatus.pending => 'Pendiente',
        NotificationStatus.sent => 'Enviado',
        NotificationStatus.failed => 'Fallido',
      };
}
