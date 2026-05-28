import 'package:flutter/material.dart' hide Notification;
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification.dart';
import 'package:intiva_mobile_application/features/communication/domain/models/notification_status.dart';

/// Card widget displaying a single [Notification] in the notifications list.
///
/// Shows a status icon, subject, recipient email, relative date, and a
/// colour-coded status badge pill.
class NotificationCard extends StatelessWidget {
  /// The notification to display.
  final Notification notification;

  /// Creates a [NotificationCard].
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final (icon, iconColor) = _iconForStatus(notification.status);
    final (badgeLabel, badgeColor) = _badgeForStatus(notification.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.subject,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  '${notification.emailAddress} · ${_relativeDate(notification.createdAt)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeLabel,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the icon and colour for the given [status].
  (IconData, Color) _iconForStatus(NotificationStatus status) =>
      switch (status) {
        NotificationStatus.sent => (
            Icons.check_circle_outline,
            AppColors.accent,
          ),
        NotificationStatus.pending => (
            Icons.access_time_outlined,
            const Color(0xFFF9A825),
          ),
        NotificationStatus.failed => (
            Icons.error_outline,
            const Color(0xFFB00020),
          ),
      };

  /// Returns the badge label and background colour for the given [status].
  (String, Color) _badgeForStatus(NotificationStatus status) =>
      switch (status) {
        NotificationStatus.sent => ('Enviado', AppColors.accent),
        NotificationStatus.pending => ('Pendiente', const Color(0xFFF9A825)),
        NotificationStatus.failed => ('Fallido', const Color(0xFFB00020)),
      };

  /// Returns a human-readable relative date string (e.g. "hace 2 días").
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
}
