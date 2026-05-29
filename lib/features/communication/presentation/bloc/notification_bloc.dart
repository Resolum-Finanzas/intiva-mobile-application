import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/communication/domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;

  NotificationBloc(this._repository) : super(const NotificationState()) {
    on<SendSimulationReport>(_onSendSimulationReport);
    on<SendPaymentReminder>(_onSendPaymentReminder);
    on<LoadNotifications>(_onLoadNotifications);
  }

  Future<void> _onSendSimulationReport(
    SendSimulationReport event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState(status: Status.loading));
    try {
      await _repository.sendSimulationReport(
        simulationId: event.simulationId,
        recipientEmail: event.recipientEmail,
      );
      emit(NotificationState(
        status: Status.success,
        successMessage: 'Report sent to ${event.recipientEmail}',
      ));
    } catch (e) {
      emit(NotificationState(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _onSendPaymentReminder(
    SendPaymentReminder event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState(status: Status.loading));
    try {
      await _repository.sendPaymentReminder(
        simulationId: event.simulationId,
        userId: event.userId,
      );
      emit(const NotificationState(
        status: Status.success,
        successMessage: 'Payment reminder sent successfully.',
      ));
    } catch (e) {
      emit(NotificationState(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState(status: Status.loading));
    try {
      final notifications =
          await _repository.getNotificationsByUser(event.userId);
      emit(NotificationState(
        status: Status.success,
        notifications: notifications,
      ));
    } catch (e) {
      emit(NotificationState(status: Status.failure, message: e.toString()));
    }
  }
}
