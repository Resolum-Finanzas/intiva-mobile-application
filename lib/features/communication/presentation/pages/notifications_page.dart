import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_bloc.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_event.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_state.dart';
import 'package:intiva_mobile_application/features/communication/presentation/widgets/notification_card.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';

class NotificationsPage extends StatelessWidget {
  final int userId;

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
          switch (state.status) {
            case Status.initial:
              return const SizedBox.shrink();
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            case Status.failure:
              return _ErrorView(
                message: state.message ?? 'An error occurred.',
                onRetry: () => context
                    .read<NotificationBloc>()
                    .add(LoadNotifications(
                      context
                          .findAncestorWidgetOfExactType<NotificationsPage>()!
                          .userId,
                    )),
              );
            case Status.success:
              return state.notifications.isEmpty
                  ? const _EmptyView()
                  : _NotificationList(notifications: state.notifications);
          }
        },
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  final List notifications;

  const _NotificationList({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: notifications.length,
      itemBuilder: (context, index) => NotificationCard(
        notification: notifications[index],
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
            color: AppColors.textHint,
          ),
          SizedBox(height: 12),
          IntivaText.body(
            'Sin notificaciones aún',
            color: AppColors.textSecondary,
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
            IntivaText.body(
              message,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
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
