import 'package:intiva_mobile_application/features/analytics/domain/models/loan_parameters.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/simulation_summary.dart';

/// Abstract contract for the loan simulation data source.
///
/// Implementations must delegate all financial computation to the backend.
abstract class LoanSimulationRepository {
  /// Creates a new simulation from the given [parameters].
  ///
  /// Returns the persisted [LoanSimulation] without a schedule.
  Future<LoanSimulation> createSimulation(LoanParameters parameters);

  /// Retrieves a simulation by its unique [simulationId].
  Future<LoanSimulation> getSimulationById(String simulationId);

  /// Retrieves all simulations belonging to the user identified by [userId].
  Future<List<SimulationSummary>> getSimulationsByUser(int userId);

  /// Triggers backend calculation of the payment schedule for [simulationId].
  ///
  /// Returns the updated [LoanSimulation] with the populated schedule.
  Future<LoanSimulation> calculateSchedule(String simulationId);

  /// Permanently deletes the simulation identified by [simulationId].
  Future<void> deleteSimulation(String simulationId);
}
