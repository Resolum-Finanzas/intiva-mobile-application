import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/bloc/catalog_state.dart';

/// This widget displays a horizontal list of category filters using [ChoiceChip].
/// It listens to the [CatalogBloc] to determine which category is currently selected and updates the UI accordingly.
/// When a category is selected, it dispatches a [FilterByCategory] event to the [CatalogBloc] to update the product list based on the selected category.
class CategoryFilter extends StatelessWidget {
  final List<String> categories;

  const CategoryFilter({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        final selected = state.selectedCategory ?? 'Todos';

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = category == selected;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    context.read<CatalogBloc>().add(
                      FilterByCategory(
                        category == 'Todos'
                            ? null
                            : category,
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}