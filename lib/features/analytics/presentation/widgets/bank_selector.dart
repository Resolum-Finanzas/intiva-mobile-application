import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

/// Horizontal chip group for selecting a bank entity.
///
/// The selected chip uses a Primary (#1A237E) fill with white text;
/// unselected chips use a white fill with Primary text and a border.
class BankSelector extends StatelessWidget {

  final String? selectedBank;
  final ValueChanged<String> onBankSelected;

  static const _banks = ['BCP', 'BBVA', 'Interbank'];

  /// Creates a [BankSelector].
  const BankSelector({
    super.key,
    required this.selectedBank,
    required this.onBankSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Entidad Bancaria',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _banks.map((bank) {
            final isSelected = bank == selectedBank;
            return GestureDetector(
              onTap: () => onBankSelected(bank),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                ),
                child: Text(
                  bank,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
