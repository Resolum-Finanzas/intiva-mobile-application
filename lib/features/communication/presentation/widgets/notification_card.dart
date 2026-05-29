import 'package:flutter/material.dart' hide Notification;
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';

class NotificationCard extends StatelessWidget {
  final Notification notification;

  const NotificationCard({super.key, required this.notification});

  (IconData, Color) _iconForStatus(NotificationStatus status) =>
      switch (status) {
        NotificationStatus.sent => (Icons.check_circle_outline, AppColors.accent),
        NotificationStatus.pending => (Icons.access_time_outlined, AppColors.warning),
        NotificationStatus.failed => (Icons.error_outline, AppColors.error),
      };

  (String, Color) _badgeForStatus(NotificationStatus status) =>
      switch (status) {
        NotificationStatus.sent => ('Enviado', AppColors.accent),
        NotificationStatus.pending => ('Pendiente', AppColors.warning),
        NotificationStatus.failed => ('Fallido', AppColors.error),
      };

  String _relativeDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'ahora mismo';
    if (diff.inMinutes < 60) return 'hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'hace ${diff.inHours} h';
    if (diff.inDays == 1) return 'hace 1 día';
    if (diff.inDays < 30) return 'hace ${diff.inDays} días';
    if (diff.inDays < 365) return 'hace ${(diff.inDays / 30).floor()} meses';
    return 'hace ${(diff.inDays / 365).floor()} años';
  }

  @override
  Widget build(BuildContext context) {
    final (icon, iconColor) = _iconForStatus(notification.status);
    final (badgeLabel, badgeColor) = _badgeForStatus(notification.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(icon, size: 20, color: iconColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntivaText.body(
                      notification.subject,
                      color: AppColors.textPrimary,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 3),
                    IntivaText.caption(
                      '${notification.emailAddress} · ${_relativeDate(notification.createdAt)}',
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    badgeLabel,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
