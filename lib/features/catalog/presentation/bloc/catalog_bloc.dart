import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/features/catalog/domain/repositories/vehicle_repository.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';


/// Bloc for managing the state of the vehicle catalog, including loading vehicles,
/// filtering by category, and loading vehicle details.
/// 
/// This Bloc listens to events such as [LoadVehicles], [FilterByCategory], and [LoadVehicleDetail],
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final VehicleRepository _repository;

  /// Initializes the [CatalogBloc] with the provided [VehicleRepository] and sets the initial state to [CatalogInitial].
  /// 
  /// Registers event handlers for loading vehicles, filtering by category, and loading vehicle details.
  /// [repository] is the data source for fetching vehicle information.
  CatalogBloc(this._repository)
      : super(const CatalogState()) {
    on<LoadVehicles>(_onLoadVehicles);
    on<FilterByCategory>(_onFilterByCategory);
    on<LoadVehicleDetail>(_onLoadVehicleDetail);
  }

  /// Handles the [LoadVehicles] event by fetching vehicles from the repository, optionally filtered by category.
  /// Emits [CatalogLoading] while fetching, and then emits [CatalogLoaded] with the fetched vehicles or [CatalogError] if an error occurs.
  /// [event] contains the category to filter vehicles by, if provided.
  /// [emit] is used to update the state of the Bloc based on the result of the fetch operation.
  Future<void> _onLoadVehicles(
    LoadVehicles event,
    Emitter<CatalogState> emit,
  ) async {
    await _fetchVehicles(emit, category: event.category);
  }

  /// Handles the [FilterByCategory] event by fetching vehicles from the repository filtered by the specified category.
  /// Emits [CatalogLoading] while fetching, and then emits [CatalogLoaded] with the
  /// fetched vehicles or [CatalogError] if an error occurs.
  /// [event] contains the category to filter vehicles by.
  /// [emit] is used to update the state of the Bloc based on the result of
  /// the fetch operation.
  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<CatalogState> emit,
  ) async {
    await _fetchVehicles(emit, category: event.category);
  }

  /// A helper method to fetch vehicles from the repository, optionally filtered by category.
  /// Emits [CatalogLoading] while fetching, and then emits [CatalogLoaded] with the fetched vehicles or [CatalogError] if an error occurs.
  /// [emit] is used to update the state of the Bloc based on the result of
  /// the fetch operation.
  /// [category] is the category to filter vehicles by, if provided.
  Future<void> _fetchVehicles(
    Emitter<CatalogState> emit, {
    String? category,
  }) async {
    emit(const CatalogState(status: Status.loading));
    try {
      final vehicles = await _repository.getVehicles(category);
      emit(CatalogState(
        status: Status.success,
        vehicles: vehicles,
        selectedCategory: category,
      ));
    } catch (e) {
      emit(CatalogState(status: Status.failure, message: e.toString()));
    }
  }

  /// Handles the [LoadVehicleDetail] event by fetching the details of a specific vehicle from the repository.
  /// Emits [CatalogDetailLoading] while fetching, and then emits [CatalogDetailLoaded] with the fetched vehicle details or [CatalogError] if an error occurs.
  /// [event] contains the ID of the vehicle to fetch details for.
  /// [emit] is used to update the state of the Bloc based on the result of the fetch operation.
  Future<void> _onLoadVehicleDetail(
    LoadVehicleDetail event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogState(status: Status.loading));
    try {
      final vehicle = await _repository.getVehicleById(event.vehicleId);
      emit(CatalogState(
        status: Status.success,
        selectedVehicle: vehicle,
      ));
    } catch (e) {
      emit(CatalogState(status: Status.failure, message: e.toString()));
    }
  }
}
