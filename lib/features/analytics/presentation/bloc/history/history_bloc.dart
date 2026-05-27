import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/repositories/loan_simulation_repository.dart';
import 'history_event.dart';
import 'history_state.dart';

/// BLoC that manages the simulation history list for a given user.
///
/// Listens to [LoadHistory] and fetches the user's past simulations from
/// [LoanSimulationRepository].
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {

  final LoanSimulationRepository _repository;

  /// Creates a [HistoryBloc] with the given [repository].
  HistoryBloc(this._repository) : super(const HistoryState()) {
    on<LoadHistory>(_onLoadHistory);
  }

  /// Handles [LoadHistory] by fetching all simulations for [event.userId].
  ///
  /// Emits [Status.loading] → [Status.success] or [Status.failure].
  Future<void> _onLoadHistory(
    LoadHistory event,
    Emitter<HistoryState> emit,
  ) async {
    emit(const HistoryState(status: Status.loading));
    try {
      final simulations =
          await _repository.getSimulationsByUser(event.userId);
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
