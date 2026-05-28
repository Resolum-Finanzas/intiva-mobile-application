import 'package:intiva_mobile_application/features/catalog/domain/models/fuel_type.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/price.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/vehicle.dart';
import 'package:intiva_mobile_application/features/catalog/domain/repositories/vehicle_repository.dart';

/// In-memory mock implementation of [VehicleRepository].
///
/// Use this during development to avoid hitting the remote API rate limit.
/// Swap back to [VehicleRepositoryImpl] in [injection.dart] when the backend
/// is ready.
class MockVehicleRepository implements VehicleRepository {
  static final List<Vehicle> _vehicles = [
    Vehicle(
      id: 'v001',
      brand: 'Toyota',
      model: 'RAV4',
      age: 2024,
      color: 'Blanco Perlado',
      fuelType: FuelType.hybrid.label,
      mileage: 0,
      price: Price(quantity: 32500, currency: 'USD', symbol: r'$'),
      category: 'SUV',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800',
    ),
    Vehicle(
      id: 'v002',
      brand: 'Tesla',
      model: 'Model 3',
      age: 2024,
      color: 'Rojo Carmesí',
      fuelType: FuelType.electric.label,
      mileage: 0,
      price: Price(quantity: 41990, currency: 'USD', symbol: r'$'),
      category: 'Sedán',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800',
    ),
    Vehicle(
      id: 'v003',
      brand: 'Honda',
      model: 'CR-V',
      age: 2023,
      color: 'Gris Metálico',
      fuelType: FuelType.gasoline.label,
      mileage: 18500,
      price: Price(quantity: 27800, currency: 'USD', symbol: r'$'),
      category: 'SUV',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800',
    ),
    Vehicle(
      id: 'v004',
      brand: 'BMW',
      model: '320i',
      age: 2024,
      color: 'Negro Zafiro',
      fuelType: FuelType.gasoline.label,
      mileage: 0,
      price: Price(quantity: 48500, currency: 'USD', symbol: r'$'),
      category: 'Sedán',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800',
    ),
    Vehicle(
      id: 'v005',
      brand: 'Hyundai',
      model: 'Tucson',
      age: 2023,
      color: 'Azul Eléctrico',
      fuelType: FuelType.hybrid.label,
      mileage: 12000,
      price: Price(quantity: 29900, currency: 'USD', symbol: r'$'),
      category: 'SUV',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=800',
    ),
    Vehicle(
      id: 'v006',
      brand: 'BYD',
      model: 'Atto 3',
      age: 2024,
      color: 'Blanco Ártico',
      fuelType: FuelType.electric.label,
      mileage: 0,
      price: Price(quantity: 35200, currency: 'USD', symbol: r'$'),
      category: 'SUV',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=800',
    ),
    Vehicle(
      id: 'v007',
      brand: 'Kia',
      model: 'Sportage',
      age: 2024,
      color: 'Verde Esmeralda',
      fuelType: FuelType.hybrid.label,
      mileage: 0,
      price: Price(quantity: 31400, currency: 'USD', symbol: r'$'),
      category: 'SUV',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1617469767053-d3b523a0b982?w=800',
    ),
    Vehicle(
      id: 'v008',
      brand: 'Mercedes-Benz',
      model: 'C200',
      age: 2024,
      color: 'Plata Iridio',
      fuelType: FuelType.gasoline.label,
      mileage: 0,
      price: Price(quantity: 56900, currency: 'USD', symbol: r'$'),
      category: 'Sedán',
      transmission: 'Automática',
      imageUrl:
          'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800',
    ),
  ];

  @override
  Future<List<Vehicle>> getVehicles(String? category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (category == null) return List.unmodifiable(_vehicles);
    return _vehicles
        .where((v) => v.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<Vehicle> getVehicleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _vehicles.firstWhere(
      (v) => v.id == id,
      orElse: () => throw Exception('Vehicle not found: $id'),
    );
  }
}
