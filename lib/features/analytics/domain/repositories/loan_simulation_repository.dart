import 'package:intiva_mobile_application/features/analytics/domain/models/loan_parameters.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/simulation_summary.dart';

abstract class LoanSimulationRepository {
  Future<LoanSimulation> createSimulation(LoanParameters parameters);

  Future<LoanSimulation> getSimulationById(String simulationId);

  Future<List<SimulationSummary>> getSimulationsByUser(int userId);

  // Triggers backend calculation and returns the simulation with schedule attached.
  Future<LoanSimulation> calculateSchedule(String simulationId);

  Future<void> deleteSimulation(String simulationId);
}
