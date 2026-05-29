import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/repositories/loan_simulation_repository.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final LoanSimulationRepository _repository;

  HistoryBloc(this._repository) : super(const HistoryState()) {
    on<LoadHistory>(_onLoadHistory);
  }

  Future<void> _onLoadHistory(
    LoadHistory event,
    Emitter<HistoryState> emit,
  ) async {
    emit(const HistoryState(status: Status.loading));
    try {
      final simulations = await _repository.getSimulationsByUser(event.userId);
      emit(HistoryState(
        status: Status.success,
        simulations: simulations,
      ));
    } catch (e) {
      emit(HistoryState(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
