import 'package:flutter/material.dart';

/// A horizontal section header widget that combines an icon and a text label.
///
/// Used inside forms and pages to visually separate grouped fields or content
/// blocks. For example, a simulator form might use this to introduce sections
/// such as "⚙ Configuración del Crédito" or "📅 Periodo de Gracia".
///
/// Both the [icon] and [label] are rendered in [Theme.of(context).colorScheme.primary]
/// so the widget adapts automatically to the active theme without hardcoding
/// brand colors — making it safe to reuse across any feature.
///
/// Example:
/// ```dart
/// SectionDivider(
///   icon: Icons.settings_outlined,
///   label: 'Configuración del Crédito',
/// )
/// ```
class SectionDivider extends StatelessWidget {
  final IconData icon;
  final String label;

  /// Creates a [SectionDivider].
  const SectionDivider({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: primaryColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
