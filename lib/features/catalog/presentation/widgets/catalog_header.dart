import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/widgets/vehicle_search_bar.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/widgets/category_filter.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

/// This widget represents the header section of the catalog screen, including a welcome message,
/// a search bar, and category filters for vehicle types.
class CatalogHeader extends StatelessWidget {
  static const _categories = ['Todos', 'SUV', 'Sedán', 'Eléctrico'];

  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IntivaText.display('Bienvenido a Intiva', color: AppColors.primary),
          const SizedBox(height: 4),
          IntivaText.body('Encuentra tu próximo vehículo',
              color: Colors.grey[600]),
          const SizedBox(height: 16),
          VehicleSearchBar(),
          const SizedBox(height: 16),
          CategoryFilter(categories: _categories),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}