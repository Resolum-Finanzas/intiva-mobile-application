import 'package:intiva_mobile_application/features/catalog/domain/models/price.dart';

///
/// Represents a vehicle in the catalog with its details.
/// This class includes properties such as brand, model, age, category, transmission type, fuel type, price, mileage, color, and an image URL.
/// The `Vehicle` class also provides a factory constructor to create an instance from a JSON object and a getter to return the full name of the vehicle.
/// 
/// Example usage:
/// ```dart
/// final vehicleJson = {
///   "id": "1",
///   "brand": "Toyota",
///   "model": "Corolla",
///   "age": 3,
///   "category": "Sedan",
///   "transmission": "Automatic",
///   "fuelType": "Gasoline",
///   "price": {
///    "amount": 15000,
///    "currency": "USD"
///    "symbol": "$"
///   },
///   "mileage": 30000,
///   "color": "Red",
///   "imageUrl": "https://example.com/vehicle.jpg"
/// };
/// 
class Vehicle {
  final String id;
  final String brand;
  final String model;
  final int age;
  final String category;
  final String transmission;
  final String fuelType;
  final Price price;
  final int mileage;
  final String color;
  final String imageUrl;

  Vehicle({
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

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json['id'],
        brand: json['brand'],
        model: json['model'],
        age: json['age'],
        category: json['category'],
        transmission: json['transmission'],
        fuelType: json['fuelType'],
        price: Price.fromJson(json['price']),
        mileage: json['mileage'],
        color: json['color'],
        imageUrl: json['imageUrl'],
      );

  String get fullName => '$brand $model $age';
}