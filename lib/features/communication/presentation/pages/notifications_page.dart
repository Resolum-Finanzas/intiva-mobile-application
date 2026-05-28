import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_bloc.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_event.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_state.dart';
import 'package:intiva_mobile_application/features/communication/presentation/widgets/notification_card.dart';

/// Page that displays the notification history for the current user.
///
/// Provides a [NotificationBloc] and immediately dispatches [LoadNotifications].
/// Shows an empty state when there are no notifications, or a [ListView] of
/// [NotificationCard] widgets when loaded.
class NotificationsPage extends StatelessWidget {

  final int userId;

  /// Creates a [NotificationsPage].
  const NotificationsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<NotificationBloc>()..add(LoadNotifications(userId)),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notificaciones',
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return switch (state) {
            NotificationInitial() => const SizedBox.shrink(),
            NotificationLoading() => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            NotificationError(:final message) => _ErrorView(
                message: message,
                onRetry: () => context
                    .read<NotificationBloc>()
                    .add(LoadNotifications(
                      (context.findAncestorWidgetOfExactType<
                                  NotificationsPage>()
                              as NotificationsPage)
                          .userId,
                    )),
              ),
            NotificationsLoaded(:final notifications) =>
              notifications.isEmpty
                  ? const _EmptyView()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) => NotificationCard(
                        notification: notifications[index],
                      ),
                    ),
            NotificationSuccess() => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mail_outline,
            size: 48,
            color: Color(0xFFBDBDBD),
          ),
          SizedBox(height: 12),
          Text(
            'Sin notificaciones aún',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF757575),
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
