import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/analytics/domain/repositories/loan_simulation_repository.dart';
import 'simulator_event.dart';
import 'simulator_state.dart';

class SimulatorBloc extends Bloc<SimulatorEvent, SimulatorState> {
  final LoanSimulationRepository _repository;

  SimulatorBloc(this._repository) : super(const SimulatorState()) {
    on<LoadSimulator>(_onLoadSimulator);
    on<CalculateSchedule>(_onCalculateSchedule);
    on<DeleteSimulation>(_onDeleteSimulation);
  }

  Future<void> _onLoadSimulator(
    LoadSimulator event,
    Emitter<SimulatorState> emit,
  ) async {
    emit(const SimulatorState(status: Status.initial));
  }

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
