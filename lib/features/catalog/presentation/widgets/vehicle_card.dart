import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/vehicle.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_button.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    final (fuelLabel, fuelColor, fuelIcon) = switch (vehicle.fuelType.toLowerCase()) {
      'híbrido' || 'hybrid' => ('Híbrido', const Color(0xFF2E7D32), Icons.eco),
      'eléctrico' || 'electric' => ('100% Eléctrico', const Color(0xFF1565C0), Icons.bolt),
      'premium' => ('Premium', const Color(0xFF6A1B9A), Icons.star),
      _ => (vehicle.fuelType, Colors.grey[700]!, Icons.local_gas_station),
    };

    Widget specItem(IconData icon, String label) {
      return Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          IntivaText.caption(label, color: Colors.grey[600]),
        ],
      );
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey[300]!, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  vehicle.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => ColoredBox(
                    color: Colors.grey[200]!,
                    child: const Icon(Icons.directions_car, size: 64, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: fuelColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(fuelIcon, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        IntivaText.caption(fuelLabel, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntivaText.subtitle(vehicle.fullName, color: primaryColor),
                          const SizedBox(height: 4),
                          IntivaText.body(
                            '${vehicle.category} • ${vehicle.transmission}',
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IntivaText.caption('DESDE', color: Colors.grey[600]),
                        IntivaText.subtitle(vehicle.price.formatted, color: primaryColor),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  children: [
                    specItem(Icons.speed, '${vehicle.mileage} km'),
                    const SizedBox(width: 16),
                    specItem(Icons.settings, vehicle.transmission),
                    const SizedBox(width: 16),
                    specItem(Icons.palette_outlined, vehicle.color),
                  ],
                ),
                const SizedBox(height: 16),
                Theme(
                  data: Theme.of(context).copyWith(
                    filledButtonTheme: FilledButtonThemeData(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF000A60),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  child: IntivaButton(label: 'Ver detalles', onPressed: onTap),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
