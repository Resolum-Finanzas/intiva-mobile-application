import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/features/communication/domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

/// BLoC that manages notification operations: sending reports, sending
/// reminders, and loading the notification list.
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  /// Repository used to perform notification operations.
  final NotificationRepository _repository;

  /// Creates a [NotificationBloc] with the given [repository].
  NotificationBloc(this._repository) : super(NotificationInitial()) {
    on<SendSimulationReport>(_onSendSimulationReport);
    on<SendPaymentReminder>(_onSendPaymentReminder);
    on<LoadNotifications>(_onLoadNotifications);
  }

  /// Handles [SendSimulationReport] by calling the repository and emitting
  /// [NotificationSuccess] or [NotificationError].
  Future<void> _onSendSimulationReport(
    SendSimulationReport event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      await _repository.sendSimulationReport(
        simulationId: event.simulationId,
        recipientEmail: event.recipientEmail,
      );
      emit(NotificationSuccess(
        'Reporte enviado a ${event.recipientEmail}',
      ));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  /// Handles [SendPaymentReminder] by calling the repository and emitting
  /// [NotificationSuccess] or [NotificationError].
  Future<void> _onSendPaymentReminder(
    SendPaymentReminder event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      await _repository.sendPaymentReminder(
        simulationId: event.simulationId,
        userId: event.userId,
      );
      emit(NotificationSuccess('Recordatorio de pago enviado.'));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  /// Handles [LoadNotifications] by fetching the list from the repository
  /// and emitting [NotificationsLoaded] or [NotificationError].
  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final notifications =
          await _repository.getNotificationsByUser(event.userId);
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
