import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/features/catalog/domain/models/vehicle.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';
import 'vehicle_card.dart';

/// This widget displays a list of vehicles in a scrollable view. It takes a list of `Vehicle` objects and a callback function that is triggered when a vehicle card is tapped. If the list of vehicles is empty, it shows a message indicating that no vehicles were found, along with an icon. Each vehicle in the list is represented by a `VehicleCard`, which displays the vehicle's information and allows users to tap on it for more details.
/// 
/// The widget is designed to be user-friendly and visually appealing, with proper spacing and styling to enhance the user experience. It uses a `ListView.separated` to create a scrollable list of vehicle cards, with separators between each card for better readability. The empty state is handled gracefully, providing feedback to the user when there are no vehicles to display. Overall, this widget serves as a key component in the catalog feature of the application, allowing users to browse through available vehicles efficiently.
/// 
/// The `VehicleList` widget is reusable and can be integrated into different parts of the application where a list of vehicles needs to be displayed. It ensures that the user interface remains consistent and provides a seamless experience when navigating through the vehicle catalog. The use of the `VehicleCard` widget within the list allows for a modular design, making it easier to maintain and update the vehicle display logic in one place.
class VehicleList extends StatelessWidget {
  final List<Vehicle> vehicles;
  final Function(String vehicleId) onVehicleTap;

  const VehicleList({
    super.key,
    required this.vehicles,
    required this.onVehicleTap,
  });

  @override
  Widget build(BuildContext context) {
    if (vehicles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            IntivaText.subtitle('No se encontraron vehículos'),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: vehicles.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return VehicleCard(
          vehicle: vehicle,
          onTap: () => onVehicleTap(vehicle.id),
        );
      },
    );
  }
}