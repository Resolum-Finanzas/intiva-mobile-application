import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/vehicle.dart';

/// Represents the state of the catalog, including the status of data fetching,
/// the list of vehicles, the selected vehicle, the selected category, and any error messages.
class CatalogState {
  final Status status;
  final List<Vehicle> vehicles;
  final Vehicle? selectedVehicle;
  final String? selectedCategory;
  final String? message;

  /// Creates a new instance of [CatalogState] with the given parameters.
  /// [status] indicates the current status of data fetching (e.g., initial, loading, success, failure).
  /// [vehicles] is the list of vehicles available in the catalog.
  /// [selectedVehicle] is the currently selected vehicle, if any.
  /// [selectedCategory] is the currently selected category, if any.
  /// [message] is an optional error message in case of a failure.
  const CatalogState({
    this.status = Status.initial,
    this.vehicles = const [],
    this.selectedVehicle,
    this.selectedCategory,
    this.message,
  });

  /// Creates a copy of the current [CatalogState] with the given parameters.
  /// This method allows for updating specific fields while keeping the rest unchanged.
  /// [status] is the new status to set, or null to keep the current status.
  /// [vehicles] is the new list of vehicles to set, or null to keep the current list.
  /// [selectedVehicle] is the new selected vehicle to set, or null to keep the current selection.
  /// [selectedCategory] is the new selected category to set, or null to keep the current selection.
  /// [message] is the new error message to set, or null to keep the current
  CatalogState copyWith({
    Status? status,
    List<Vehicle>? vehicles,
    Vehicle? selectedVehicle,
    String? selectedCategory,
    String? message,
  }) {
    return CatalogState(
      status: status ?? this.status,
      vehicles: vehicles ?? this.vehicles,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      message: message ?? this.message,
    );
  }
}