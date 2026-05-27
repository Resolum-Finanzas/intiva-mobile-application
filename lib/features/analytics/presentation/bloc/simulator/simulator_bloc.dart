import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/repositories/loan_simulation_repository.dart';
import 'simulator_event.dart';
import 'simulator_state.dart';

/// BLoC that manages the loan simulator form and schedule calculation flow.
///
/// Responsibilities:
/// - Initialise the form with vehicle data ([LoadSimulator]).
/// - Create a simulation and request schedule calculation ([CalculateSchedule]).
/// - Delete an existing simulation ([DeleteSimulation]).
///
/// All financial computation is delegated to the backend via [LoanSimulationRepository].
class SimulatorBloc extends Bloc<SimulatorEvent, SimulatorState> {

  final LoanSimulationRepository _repository;

  /// Creates a [SimulatorBloc] with the given [repository].
  SimulatorBloc(this._repository) : super(const SimulatorState()) {
    on<LoadSimulator>(_onLoadSimulator);
    on<CalculateSchedule>(_onCalculateSchedule);
    on<DeleteSimulation>(_onDeleteSimulation);
  }

  /// Handles [LoadSimulator] by resetting the state to initial so the form
  /// is ready for the given vehicle.
  Future<void> _onLoadSimulator(
    LoadSimulator event,
    Emitter<SimulatorState> emit,
  ) async {
    emit(const SimulatorState(status: Status.initial));
  }

  /// Handles [CalculateSchedule] by:
  /// 1. Creating a simulation from [event.parameters].
  /// 2. Requesting schedule calculation for the returned simulation ID.
  ///
  /// Emits [Status.loading] → [Status.success] or [Status.failure].
  Future<void> _onCalculateSchedule(
    CalculateSchedule event,
    Emitter<SimulatorState> emit,
  ) async {
    emit(const SimulatorState(status: Status.loading));
    try {
      final simulation =
          await _repository.createSimulation(event.parameters);
      final withSchedule =
          await _repository.calculateSchedule(simulation.id);
      emit(SimulatorState(
        status: Status.success,
        simulation: withSchedule,
      ));
    } catch (e) {
      emit(SimulatorState(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }

  /// Handles [DeleteSimulation] by deleting the simulation and resetting state.
  Future<void> _onDeleteSimulation(
    DeleteSimulation event,
    Emitter<SimulatorState> emit,
  ) async {
    emit(const SimulatorState(status: Status.loading));
    try {
      await _repository.deleteSimulation(event.simulationId);
      emit(const SimulatorState(status: Status.initial));
    } catch (e) {
      emit(SimulatorState(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
