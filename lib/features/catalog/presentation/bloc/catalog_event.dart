/// Events for the CatalogBloc, which manages the state of the vehicle catalog in the application.
sealed class CatalogEvent {}

/// Event to load the list of vehicles, optionally filtered by a specific category.
/// If [category] is null, it will load all vehicles. Otherwise, it will load only vehicles that belong to the specified category.
class LoadVehicles extends CatalogEvent {
  final String? category;
  LoadVehicles({this.category});
}

/// Event to filter the list of vehicles by a specific category. This event can be used to update the displayed list of vehicles based on the selected category.
/// If [category] is null, it will clear the filter and show all vehicles. Otherwise, it will show only vehicles that belong to the specified category.
class FilterByCategory extends CatalogEvent {
  final String? category;
  FilterByCategory(this.category);
}

/// Event to load the details of a specific vehicle, identified by its [vehicleId]. This event is typically triggered when a user selects a vehicle from the list to view more information about it.
/// The [vehicleId] is used to fetch the detailed information about the selected vehicle, which may include specifications, features, pricing, and other relevant details.
class LoadVehicleDetail extends CatalogEvent {
  final String vehicleId;
  LoadVehicleDetail(this.vehicleId);
}