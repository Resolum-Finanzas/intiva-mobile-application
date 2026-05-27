import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/simulation_summary.dart';

/// Represents the state managed by [HistoryBloc].
class HistoryState {

  final Status status;

  /// List of simulation summaries; populated after a successful [LoadHistory].
  final List<SimulationSummary> simulations;

  /// Error message; populated when [status] is [Status.failure].
  final String? message;

  /// Creates a [HistoryState] with sensible defaults.
  const HistoryState({
    this.status = Status.initial,
    this.simulations = const [],
    this.message,
  });

  /// Returns a copy of this state with the given fields replaced.
  HistoryState copyWith({
    Status? status,
    List<SimulationSummary>? simulations,
    String? message,
  }) {
    return HistoryState(
      status: status ?? this.status,
      simulations: simulations ?? this.simulations,
      message: message ?? this.message,
    );
  }
}
