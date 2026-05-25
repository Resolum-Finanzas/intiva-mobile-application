import 'package:json_annotation/json_annotation.dart';

part 'price_dto.g.dart';

/// This class represents the price details of a product, including the quantity, currency, and symbol. It is used to transfer price data between the remote data source and the application.
/// 
/// The `PriceDto` class is annotated with `@JsonSerializable()` to enable JSON serialization and deserialization using the `json_serializable` package. The `fromJson` factory constructor allows creating an instance of `PriceDto` from a JSON map, which is useful when receiving data from an API response.
@JsonSerializable()
class PriceDto {
  final double quantity;
  final String currency;
  final String symbol;

  /// Creates a [PriceDto] instance with the given parameters.
  /// The [quantity] parameter represents the price amount, [currency] is the currency code (e.g., "USD"), and [symbol] is the currency symbol (e.g., "$").
  const PriceDto({
    required this.quantity,
    required this.currency,
    required this.symbol,
  });

  /// Creates a [PriceDto] from a JSON map.
  /// The [json] parameter is a map containing the price data, which is deserialized into a [PriceDto] instance using the generated code from `json_serializable`.
  factory PriceDto.fromJson(Map<String, dynamic> json) =>
      _$PriceDtoFromJson(json);
}