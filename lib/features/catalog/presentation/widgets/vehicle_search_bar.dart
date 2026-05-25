import 'package:flutter/material.dart';

/// This widget represents a search bar for filtering vehicles in the catalog. It provides a user interface for entering search queries, allowing users to quickly find specific vehicles based on their input. The search bar is designed to be visually consistent with the overall theme of the application, using appropriate colors and styling to enhance the user experience.
/// 
/// The `VehicleSearchBar` widget is reusable and can be integrated into different parts of the application where a search functionality for vehicles is needed. It includes a leading search icon to indicate its purpose and a hint text to guide users on what they can search for. The `onChanged` callback allows developers to implement the logic for filtering the vehicle list based on the user's input, making it a crucial component for improving the usability of the vehicle catalog feature.
/// 
/// Overall, the `VehicleSearchBar` enhances the user experience by providing an intuitive and efficient way to search through the vehicle catalog, making it easier for users to find the vehicles they are interested in.
class VehicleSearchBar extends StatelessWidget {
  const VehicleSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      side: WidgetStateProperty.all(
        const BorderSide(color: Colors.grey, width: 1.5),
      ),
      hintText: 'Buscar vehículo...',
      leading: const Icon(Icons.search),
      onChanged: (query) {},
    );
  }
}
