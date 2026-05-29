import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

/// Displays a formatted table of BCP vehicle insurance annual rates
/// categorised by risk level.
///
/// All data is hardcoded from official BCP tariff documentation to guarantee
/// accuracy and offline availability — no API call is required. The table is
/// intended to be embedded inside a [BankRateCard] on [ConfigurationPage].
///
/// Rate values are highlighted in [AppColors.secondary] (green) to draw
/// attention to the cost of each risk category and maintain visual hierarchy
/// consistent with the rest of the configuration screen.
///
/// The table uses Flutter's [Table] widget with two columns:
/// - **Nivel de Riesgo** — the risk category name (flex width).
/// - **Tasa Anual** — the annual rate percentage (intrinsic / right-aligned).
///
/// Alternating row backgrounds (white / light grey) improve readability for
/// users scanning multiple entries.
///
/// Example:
/// ```dart
/// BankRateCard(
///   headerColor: AppColors.secondary,
///   headerIcon: Icons.directions_car_outlined,
///   headerTitle: 'Tasas del seguro vehicular',
///   body: Column(
///     children: [
///       IntivaText.body('Descripción...'),
///       const SizedBox(height: 12),
///       const InsuranceRateTable(),
///     ],
///   ),
/// )
/// ```
class InsuranceRateTable extends StatelessWidget {
  /// Creates an [InsuranceRateTable].
  const InsuranceRateTable({super.key});

  /// Hardcoded BCP vehicle insurance rate rows.
  /// Each record is a (riskLevel, annualRate) tuple.
  static const _rows = [
    ('Bajo Riesgo 1', '4.86%'),
    ('Bajo Riesgo 2', '5.85%'),
    ('Riesgo Medio', '6.50%'),
    ('Riesgo Alto', '7.25%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(),
        1: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
          children: [
            _headerCell('Nivel de Riesgo'),
            _headerCell('Tasa Anual', align: TextAlign.right),
          ],
        ),
        ..._rows.asMap().entries.map((entry) {
          final isEven = entry.key.isEven;
          final (risk, rate) = entry.value;
          return TableRow(
            decoration: BoxDecoration(
              color: isEven ? Colors.white : const Color(0xFFF5F5F5),
            ),
            children: [
              _dataCell(risk),
              _dataCell(rate, color: AppColors.secondary, align: TextAlign.right),
            ],
          );
        }),
      ],
    );
  }

  /// Builds a header cell with bold Inter 12 px text.
  Widget _headerCell(String text, {TextAlign align = TextAlign.left}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Text(
          text,
          textAlign: align,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  /// Builds a data cell with Inter 13 px text, optionally coloured.
  Widget _dataCell(
    String text, {
    Color? color,
    TextAlign align = TextAlign.left,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: color != null ? FontWeight.w600 : FontWeight.w400,
            color: color,
          ),
        ),
      );
}
