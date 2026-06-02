import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';

class SimulatorState {
  final Status status;
  final LoanSimulation? simulation;
  final String? message;

  const SimulatorState({
    this.status = Status.initial,
    this.simulation,
    this.message,
  });

  static const _absent = Object();

  SimulatorState copyWith({
    Status? status,
    LoanSimulation? simulation,
    Object? message = _absent,
  }) {
    return SimulatorState(
      status: status ?? this.status,
      simulation: simulation ?? this.simulation,
      message: message == _absent ? this.message : message as String?,
    );
  }
}
