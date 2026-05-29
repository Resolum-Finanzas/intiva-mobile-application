import 'package:intiva_mobile_application/features/analytics/domain/models/loan_parameters.dart';

abstract class SimulatorEvent {}

class LoadSimulator extends SimulatorEvent {
  final String vehicleId;
  final String vehicleName;
  /// Base price of the vehicle in USD.
  final double vehiclePrice;

  LoadSimulator({
    required this.vehicleId,
    required this.vehicleName,
    required this.vehiclePrice,
  });
}

class CalculateSchedule extends SimulatorEvent {
  final LoanParameters parameters;

  CalculateSchedule(this.parameters);
}

class DeleteSimulation extends SimulatorEvent {
  final String simulationId;

  DeleteSimulation(this.simulationId);
}
