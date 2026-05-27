import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';

/// 2×2 grid of financial metric cards shown on the payment plan page.
///
/// Displays TEA, TCEA, Grace Interest, and VAN/TIR.
class FinancialMetricsCard extends StatelessWidget {

  final LoanSimulation simulation;

  /// Creates a [FinancialMetricsCard].
  const FinancialMetricsCard({super.key, required this.simulation});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        _MetricTile(
          label: 'TEA',
          value: '${simulation.teaPercentage.toStringAsFixed(2)}%',
          dark: false,
        ),
        _MetricTile(
          label: 'TCEA',
          value: '${simulation.tceaPercentage.toStringAsFixed(2)}%',
          dark: false,
        ),
        _MetricTile(
          label: 'Int. Gracia',
          value: '\$${simulation.graceInterest.toStringAsFixed(2)}',
          dark: false,
        ),
        _MetricTile(
          label: 'VAN / TIR',
          value:
              '\$${simulation.van.toStringAsFixed(2)} / ${simulation.tir.toStringAsFixed(2)}%',
          dark: true,
        ),
      ],
    );
  }
}

/// Individual metric tile used inside [FinancialMetricsCard].
class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final bool dark;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.primary : Colors.white;
    final labelColor = dark ? Colors.white70 : AppColors.textSecondary;
    final valueColor = dark ? Colors.white : AppColors.textPrimary;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: dark
            ? null
            : Border.all(color: AppColors.border),
        boxShadow: dark
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
