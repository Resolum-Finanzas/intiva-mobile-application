enum NotificationStatus {
  pending,
  sent,
  failed;

  String get label => switch (this) {
        NotificationStatus.pending => 'Pendiente',
        NotificationStatus.sent => 'Enviado',
        NotificationStatus.failed => 'Fallido',
      };
}
