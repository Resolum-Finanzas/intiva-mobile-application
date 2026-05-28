import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

/// Displays a formatted table of BCP interest rate ranges segmented by
/// financed amount in USD.
///
/// All data is hardcoded from official BCP published rate sheets to guarantee
/// accuracy and offline availability — no API call is required. The table is
/// intended to be embedded inside a [BankRateCard] on [ConfigurationPage].
///
/// Rate ranges are highlighted in [AppColors.primary] (navy) to maintain
/// visual hierarchy and brand consistency, distinguishing this table from
/// [InsuranceRateTable] which uses [AppColors.secondary] (green).
///
/// The table uses Flutter's [Table] widget with two columns:
/// - **Monto Financiado** — the financed amount range in USD (flex width).
/// - **Rango de Tasas** — the applicable interest rate range (intrinsic / right-aligned).
///
/// Alternating row backgrounds (white / light grey) improve readability for
/// users scanning multiple entries.
///
/// Example:
/// ```dart
/// BankRateCard(
///   headerColor: AppColors.primary,
///   headerIcon: Icons.bar_chart,
///   headerTitle: 'Tasas de interés según monto',
///   body: Column(
///     children: [
///       IntivaText.body('Descripción...'),
///       const SizedBox(height: 12),
///       const InterestRangeTable(),
///     ],
///   ),
/// )
/// ```
class InterestRangeTable extends StatelessWidget {
  /// Creates an [InterestRangeTable].
  const InterestRangeTable({super.key});

  /// Hardcoded BCP interest rate range rows.
  /// Each record is a (financedAmountRange, rateRange) tuple.
  static const _rows = [
    ('De US\$ 3,750 a US\$ 8,250', '11.65% – 17.15%'),
    ('De US\$ 8,251 a US\$ 15,000', '10.25% – 15.50%'),
    ('Más de US\$ 15,000', '8.49% – 13.99%'),
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
            _headerCell('Monto Financiado'),
            _headerCell('Rango de Tasas', align: TextAlign.right),
          ],
        ),
        ..._rows.asMap().entries.map((entry) {
          final isEven = entry.key.isEven;
          final (amount, rate) = entry.value;
          return TableRow(
            decoration: BoxDecoration(
              color: isEven ? Colors.white : const Color(0xFFF5F5F5),
            ),
            children: [
              _dataCell(amount),
              _dataCell(rate, color: AppColors.primary, align: TextAlign.right),
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
