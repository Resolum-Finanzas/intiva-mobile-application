import 'package:flutter/material.dart';

/// A reusable card widget with a colored header bar and a white content body.
///
/// Designed primarily for [ConfigurationPage] to display grouped BCP rate
/// information in a visually distinct, scannable format. The card uses a
/// rounded container with a subtle border and a full-width colored header
/// that accepts a custom [headerColor], [headerIcon], and [headerTitle].
///
/// The [body] slot is intentionally generic — it accepts any widget, allowing
/// callers to embed tables ([InsuranceRateTable], [InterestRangeTable]),
/// descriptive text, or any other content without coupling this widget to a
/// specific data shape.
///
/// The header icon and title are always rendered in white for maximum contrast
/// against any [headerColor] value.
///
/// Example:
/// ```dart
/// BankRateCard(
///   headerColor: AppColors.secondary,
///   headerIcon: Icons.shield_outlined,
///   headerTitle: 'Tasas del seguro de desgravamen',
///   body: Text('Contenido aquí'),
/// )
/// ```
class BankRateCard extends StatelessWidget {
  final Color headerColor;
  final IconData headerIcon;
  final String headerTitle;
  final Widget body;

  /// Creates a [BankRateCard].
  const BankRateCard({
    super.key,
    required this.headerColor,
    required this.headerIcon,
    required this.headerTitle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(headerIcon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    headerTitle,
                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: body,
          ),
        ],
      ),
    );
  }
}
