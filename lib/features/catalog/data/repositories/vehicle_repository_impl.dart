import 'package:dio/dio.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/vehicle.dart';
import 'package:intiva_mobile_application/features/catalog/domain/repositories/vehicle_repository.dart';
import 'package:intiva_mobile_application/features/catalog/data/remote/services/vehicle_service.dart';

/// Implementation of [VehicleRepository] that uses [VehicleService] to fetch data from a remote API.
/// Handles errors by mapping Dio exceptions to user-friendly messages.
/// This class is responsible for fetching vehicle data and converting it from DTOs to domain models.
/// It provides methods to get a list of vehicles and to get a specific vehicle by its ID.
class VehicleRepositoryImpl implements VehicleRepository {

  /// The service used to fetch vehicle data from the remote API.
  final VehicleService _service;

  /// Creates an instance of [VehicleRepositoryImpl] with the given [VehicleService].
  /// [service] is required and must not be null.
  VehicleRepositoryImpl(this._service);

  /// Fetches a list of vehicles from the remote API, optionally filtered by category.
  /// If [category] is provided, only vehicles belonging to that category will be returned.
  /// If an error occurs during the fetch, an exception with a user-friendly message will be
  /// thrown.
  @override
  Future<List<Vehicle>> getVehicles(String? category) async {
    try {
      final dtos = await _service.getVehicles(category: category);
      return dtos.map((dto) => dto.toDomain()).toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  /// Fetches a specific vehicle by its ID from the remote API.
  /// If the vehicle with the given [id] is not found, an exception with a
  /// user-friendly message will be thrown. If any other error occurs during the fetch, an exception
  /// with a user-friendly message will also be thrown.
  @override
  Future<Vehicle> getVehicleById(String id) async {
    try {
      final dto = await _service.getVehicleById(id);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  /// Maps a [DioException] to a user-friendly [Exception] with a message that can be displayed
  /// to the user. The mapping is based on the type of the Dio exception and, in some cases, the HTTP status code of the response.
  /// 
  /// For example, if the exception is a connection timeout, it will return an exception with the message "Time out de conexión". If the exception is a bad response with a 404 status code, it will return an exception with the message "Vehicle not found". For any other types of exceptions, it will return a generic network error message.
  /// 
  Exception _mapError(DioException e) => switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout =>
          Exception('Time out de conexión'),
        DioExceptionType.badResponse => switch (e.response?.statusCode) {
            404 => Exception('Vehicle not found'),
            401 => Exception('Not authorized'),
            _ => Exception('Server error: ${e.response?.statusCode}'),
          },
        _ => Exception('Network error: ${e.message}'),
      };
}