import 'package:intiva_mobile_application/features/analytics/domain/models/loan_parameters.dart';

/// Base class for all events handled by [SimulatorBloc].
sealed class SimulatorEvent {}

/// Initialises the simulator form for the given vehicle.
///
/// [vehicleId] and [vehiclePrice] are injected via GoRouter extras and must
/// never be stored in global state.
class LoadSimulator extends SimulatorEvent {

  final String vehicleId;
  final String vehicleName;
  final double vehiclePrice;

  /// Creates a [LoadSimulator] event.
  LoadSimulator({
    required this.vehicleId,
    required this.vehicleName,
    required this.vehiclePrice,
  });
}

/// Submits the simulator form to create a simulation and then calculate its schedule.
///
/// [parameters] encapsulates all user-configured loan parameters.
class CalculateSchedule extends SimulatorEvent {
  final LoanParameters parameters;
  CalculateSchedule(this.parameters);
}

/// Requests deletion of the simulation identified by [simulationId].
class DeleteSimulation extends SimulatorEvent {
  final String simulationId;
  DeleteSimulation(this.simulationId);
}
