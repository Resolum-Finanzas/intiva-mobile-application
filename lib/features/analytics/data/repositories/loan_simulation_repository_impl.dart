import 'package:dio/dio.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/create_loan_simulation_dto.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/simulation_summary_dto.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/services/loan_simulation_service.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_parameters.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/simulation_summary.dart';
import 'package:intiva_mobile_application/features/analytics/domain/repositories/loan_simulation_repository.dart';

class LoanSimulationRepositoryImpl implements LoanSimulationRepository {
  final LoanSimulationService _service;

  LoanSimulationRepositoryImpl(this._service);

  @override
  Future<LoanSimulation> createSimulation(LoanParameters parameters) async {
    try {
      final dto = await _service.createSimulation(
        CreateLoanSimulationDto(
          vehicleId: parameters.vehicleId,
          vehicleName: parameters.vehicleName,
          vehiclePrice: parameters.vehiclePrice,
          initialPaymentPercentage: parameters.initialPaymentPercentage,
          bankEntity: parameters.bankEntity,
          teaPercentage: parameters.teaPercentage,
          termMonths: parameters.termMonths,
          balloonPaymentPercentage: parameters.balloonPaymentPercentage,
          vehicularInsuranceEnabled: parameters.vehicularInsuranceEnabled,
          vehicularInsuranceRate: parameters.vehicularInsuranceRate,
          desgravamenInsuranceEnabled: parameters.desgravamenInsuranceEnabled,
          gracePeriodEnabled: parameters.gracePeriodEnabled,
          gracePeriodType: parameters.gracePeriodType,
          gracePeriodMonths: parameters.gracePeriodMonths,
          loanStartDate: parameters.loanStartDate.toIso8601String(),
        ),
      );
      return dto.toDomain();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<LoanSimulation> getSimulationById(String simulationId) async {
    try {
      final dto = await _service.getSimulationById(simulationId);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<List<SimulationSummary>> getSimulationsByUser(int userId) async {
    try {
      final dtos = await _service.getSimulationsByUser(userId);
      return dtos.map(_summaryToDomain).toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<LoanSimulation> calculateSchedule(String simulationId) async {
    try {
      final dto = await _service.calculateSchedule(simulationId);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<void> deleteSimulation(String simulationId) async {
    try {
      await _service.deleteSimulation(simulationId);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  SimulationSummary _summaryToDomain(SimulationSummaryDto dto) =>
      SimulationSummary(
        id: dto.id,
        vehicleName: dto.vehicleName,
        financedAmount: dto.financedAmount,
        teaPercentage: dto.teaPercentage,
        termMonths: dto.termMonths,
        estimatedMonthlyPayment: dto.estimatedMonthlyPayment,
        createdAt: DateTime.parse(dto.createdAt),
      );

  Exception _mapError(DioException e) => switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout =>
          Exception('Connection timed out. Please try again.'),
        DioExceptionType.badResponse => switch (e.response?.statusCode) {
            404 => Exception('Simulation not found.'),
            401 => Exception('Not authorized.'),
            422 => Exception(
                'Invalid simulation parameters: '
                '${e.response?.data?['message'] ?? 'check your inputs.'}',
              ),
            _ => Exception('Server error: ${e.response?.statusCode}'),
          },
        _ => Exception('Network error: ${e.message}'),
      };
}
