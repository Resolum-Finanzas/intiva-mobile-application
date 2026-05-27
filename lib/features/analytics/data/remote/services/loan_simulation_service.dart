import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/create_loan_simulation_dto.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/loan_simulation_dto.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/models/simulation_summary_dto.dart';

part 'loan_simulation_service.g.dart';

/// Retrofit-annotated service for all loan simulation API endpoints.
@RestApi()
abstract class LoanSimulationService {
  /// Creates a [LoanSimulationService] bound to the given [dio] client.
  ///
  /// An optional [baseUrl] overrides the client's base URL.
  factory LoanSimulationService(Dio dio, {String baseUrl}) =
      _LoanSimulationService;

  /// Creates a new loan simulation.
  ///
  /// [body] contains all parameters required to initialise the simulation.
  /// Returns the persisted [LoanSimulationDto] without a schedule.
  @POST('/api/v1/simulations')
  Future<LoanSimulationDto> createSimulation(
    @Body() CreateLoanSimulationDto body,
  );

  /// Retrieves a simulation by its unique [id].
  @GET('/api/v1/simulations/{id}')
  Future<LoanSimulationDto> getSimulationById(@Path('id') String id);

  /// Retrieves all simulations belonging to the user identified by [userId].
  @GET('/api/v1/simulations/user/{userId}')
  Future<List<SimulationSummaryDto>> getSimulationsByUser(
    @Path('userId') int userId,
  );

  /// Triggers backend calculation of the payment schedule for simulation [id].
  ///
  /// Returns the updated [LoanSimulationDto] with the populated schedule.
  @POST('/api/v1/simulations/{id}/schedule')
  Future<LoanSimulationDto> calculateSchedule(@Path('id') String id);

  /// Permanently deletes the simulation identified by [id].
  @DELETE('/api/v1/simulations/{id}')
  Future<void> deleteSimulation(@Path('id') String id);
}
