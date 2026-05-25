import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:intiva_mobile_application/features/catalog/data/remote/models/vehicle_dto.dart';
import 'package:intiva_mobile_application/core/network/api/api_endpoints.dart';

part 'vehicle_service.g.dart';

/// Retrofit service for fetching vehicle data from the API.
/// 
/// This service defines methods to retrieve a list of vehicles and to get details of a specific vehicle by its ID.
@RestApi()
abstract class VehicleService {

  /// Creates an instance of [VehicleService] with the provided [Dio] client and optional [baseUrl].
  factory VehicleService(Dio dio, {String baseUrl}) = _VehicleService;

  /// Fetches a list of vehicles from the API, optionally filtered by category.
  /// 
  /// [category] is an optional query parameter that can be used to filter vehicles by their
  /// category (e.g., "cars"). This method returns a list of [VehicleDto] objects representing the vehicles that match the specified criteria.
  @GET(ApiEndpoints.vehicles)
  Future<List<VehicleDto>> getVehicles({
    @Query('category') String? category,
  });

  /// Fetches the details of a specific vehicle by its ID.
  /// 
  /// [id] is the unique identifier of the vehicle to retrieve. This method returns a [VehicleDto] containing the details of the specified vehicle.
  @GET(ApiEndpoints.vehicleById)
  Future<VehicleDto> getVehicleById(@Path('id') String id);

}