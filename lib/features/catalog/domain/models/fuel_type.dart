/// Fuel type classification for a vehicle.
enum FuelType {

  gasoline,
  diesel,
  electric,
  hybrid;

  /// Parses a raw API string into a [FuelType] value.
  ///
  /// Falls back to [FuelType.gasoline] for unrecognised strings.
  static FuelType fromString(String raw) => switch (raw.toLowerCase()) {
        'diesel' => FuelType.diesel,
        'electric' || 'eléctrico' => FuelType.electric,
        'hybrid' || 'híbrido' => FuelType.hybrid,
        _ => FuelType.gasoline,
      };

  /// Human-readable Spanish label used in the UI.
  String get label => switch (this) {
        FuelType.gasoline => 'Gasolina',
        FuelType.diesel => 'Diésel',
        FuelType.electric => '100% Eléctrico',
        FuelType.hybrid => 'Híbrido',
      };
}
