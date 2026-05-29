import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/simulation_summary.dart';

class HistoryState {
  final Status status;
  final List<SimulationSummary> simulations;
  /// Error message for the UI.
  final String? message;

  const HistoryState({
    this.status = Status.initial,
    this.simulations = const [],
    this.message,
  });

  static const _absent = Object();

  HistoryState copyWith({
    Status? status,
    List<SimulationSummary>? simulations,
    Object? message = _absent,
  }) {
    return HistoryState(
      status: status ?? this.status,
      simulations: simulations ?? this.simulations,
      message: message == _absent ? this.message : message as String?,
    );
  }
}
