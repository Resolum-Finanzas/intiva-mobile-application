import 'package:intiva_mobile_application/features/catalog/data/remote/models/price_dto.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/vehicle.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/price.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_dto.g.dart';

/// Data Transfer Object (DTO) for Vehicle, used for JSON serialization and deserialization.
/// 
/// This class represents the structure of the vehicle data as received from or sent to a remote API.
/// It includes a method to convert the DTO to the domain model [Vehicle] for use within the application.
/// 
/// The [VehicleDto] class is annotated with `@JsonSerializable()` to enable code generation for JSON serialization.
@JsonSerializable()
class VehicleDto {
  final String id;
  final String brand;
  final String model;
  final int age;
  final String category;
  final String transmission;
  final String fuelType;
  final PriceDto price;
  final int mileage;
  final String color;
  final String imageUrl;

  /// Creates a [VehicleDto] instance with the given parameters.
  /// All parameters are required and must be provided when creating an instance of [VehicleDto].
  const VehicleDto({
    required this.id,
    required this.brand,
    required this.model,
    required this.age,
    required this.category,
    required this.transmission,
    required this.fuelType,
    required this.price,
    required this.mileage,
    required this.color,
    required this.imageUrl,
  });

  /// Factory constructor for creating a new [VehicleDto] instance from a JSON map.
  /// The [json] parameter is a map containing the key-value pairs representing the vehicle data in JSON format.
  /// This constructor uses the generated function `_$VehicleDtoFromJson` to parse the JSON and create an instance of [VehicleDto].
  factory VehicleDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleDtoFromJson(json);

  /// Converts the [VehicleDto] instance to a JSON map.
  /// This method uses the generated function `_$VehicleDtoToJson` to serialize the [VehicleDto] instance into a JSON map that can be sent to a remote API or stored locally.
  /// The returned map contains key-value pairs representing the vehicle data in JSON format.
  Vehicle toDomain() => Vehicle(
        id: id,
        brand: brand,
        model: model,
        age: age,
        category: category,
        transmission: transmission,
        fuelType: fuelType,
        price: Price(
          quantity: price.quantity,
          currency: price.currency,
          symbol: price.symbol,
        ),
        mileage: mileage,
        color: color,
        imageUrl: imageUrl,
      );
}