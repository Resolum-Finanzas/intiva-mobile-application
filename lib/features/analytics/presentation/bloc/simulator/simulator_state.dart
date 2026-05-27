import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';

/// Represents the state managed by [SimulatorBloc].
class SimulatorState {

  final Status status;
  final LoanSimulation? simulation;
  final String? message;

  /// Creates a [SimulatorState] with sensible defaults.
  const SimulatorState({
    this.status = Status.initial,
    this.simulation,
    this.message,
  });

  /// Returns a copy of this state with the given fields replaced.
  SimulatorState copyWith({
    Status? status,
    LoanSimulation? simulation,
    String? message,
  }) {
    return SimulatorState(
      status: status ?? this.status,
      simulation: simulation ?? this.simulation,
      message: message ?? this.message,
    );
  }
}
