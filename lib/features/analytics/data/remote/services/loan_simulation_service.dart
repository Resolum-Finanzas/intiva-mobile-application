import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/create_loan_simulation_dto.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/loan_simulation_dto.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/simulation_summary_dto.dart';

part 'loan_simulation_service.g.dart';

@RestApi()
abstract class LoanSimulationService {
  factory LoanSimulationService(Dio dio, {String baseUrl}) =
      _LoanSimulationService;

  @POST('/api/v1/simulations')
  Future<LoanSimulationDto> createSimulation(
    @Body() CreateLoanSimulationDto body,
  );

  @GET('/api/v1/simulations/{id}')
  Future<LoanSimulationDto> getSimulationById(@Path('id') String id);

  @GET('/api/v1/simulations/user/{userId}')
  Future<List<SimulationSummaryDto>> getSimulationsByUser(
    @Path('userId') int userId,
  );

  /// Triggers backend schedule calculation; returns the simulation with periods attached.
  @POST('/api/v1/simulations/{id}/schedule')
  Future<LoanSimulationDto> calculateSchedule(@Path('id') String id);

  @DELETE('/api/v1/simulations/{id}')
  Future<void> deleteSimulation(@Path('id') String id);
}
