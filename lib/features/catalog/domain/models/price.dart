///
/// Price model representing the price of a product in the catalog.
/// Includes the quantity, currency, and symbol for formatting purposes.
/// This model is used to encapsulate the price information for products in the catalog feature of the application.
class Price {
  final double quantity;
  final String currency;
  final String symbol;

  Price({required this.quantity, required this.currency, required this.symbol});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        quantity: (json['quantity'] as num).toDouble(),
        currency: json['currency'],
        symbol: json['symbol'],
      );

  String get formatted => '$symbol${quantity.toStringAsFixed(0)}';
}