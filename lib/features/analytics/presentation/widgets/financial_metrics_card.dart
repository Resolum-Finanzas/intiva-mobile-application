import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';

class FinancialMetricsCard extends StatelessWidget {
  final LoanSimulation simulation;

  const FinancialMetricsCard({super.key, required this.simulation});

  Widget _metricTile(String label, String value, {bool dark = false}) {
    final bg = dark ? AppColors.primary : Colors.white;
    final labelColor = dark ? Colors.white70 : AppColors.textSecondary;
    final valueColor = dark ? Colors.white : AppColors.textPrimary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: dark ? null : Border.all(color: AppColors.border),
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
      child: Padding(
        padding: const EdgeInsets.all(14),
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
      ),
    );
  }

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
        _metricTile('TEA', '${simulation.teaPercentage.toStringAsFixed(2)}%'),
        _metricTile('TCEA', '${simulation.tceaPercentage.toStringAsFixed(2)}%'),
        _metricTile('Int. Gracia', '\$${simulation.graceInterest.toStringAsFixed(2)}'),
        _metricTile(
          'VAN / TIR',
          '\$${simulation.van.toStringAsFixed(2)} / ${simulation.tir.toStringAsFixed(2)}%',
          dark: true,
        ),
      ],
    );
  }
}
