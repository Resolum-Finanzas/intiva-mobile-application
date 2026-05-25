import 'package:intiva_mobile_application/features/catalog/domain/models/vehicle.dart';

///
/// Repository for fetching vehicle data.
/// This abstracts the data source, allowing for flexibility in implementation (e.g., API, local database).
abstract class VehicleRepository {

  /// Fetches a list of vehicles, optionally filtered by category.
  /// [category] can be used to filter vehicles by their category (e.g., "SUV", "Sedan").
  /// Returns a list of [Vehicle] objects.
  Future<List<Vehicle>> getVehicles(String? category);

  /// Fetches a single vehicle by its unique identifier.
  /// [id] is the unique identifier of the vehicle to fetch.
  /// Returns a [Vehicle] object corresponding to the provided [id].
  Future<Vehicle> getVehicleById(String id);
}