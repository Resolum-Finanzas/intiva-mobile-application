import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/payment_period.dart';

/// Card displaying the details of a balloon payment period.
///
/// Uses a Secondary green (#2E7D32) background at 15% opacity and a
/// "CUOTA BALÓN" chip with a solid Secondary fill.
class BalloonPeriodCard extends StatelessWidget {

  final PaymentPeriod period;

  /// Creates a [BalloonPeriodCard].
  const BalloonPeriodCard({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BalloonHeader(
            periodNumber: period.periodNumber,
            paymentDate: period.paymentDate,
          ),
          const Divider(height: 16),
          _FieldRow(
            label: 'Saldo Inicial',
            value: '\$${period.initialBalance.toStringAsFixed(2)}',
          ),
          _FieldRow(
            label: 'Interés',
            value: '\$${period.interest.toStringAsFixed(2)}',
          ),
          _FieldRow(
            label: 'Amortización',
            value: '\$${period.amortization.toStringAsFixed(2)}',
          ),
          _FieldRow(
            label: 'Pago Final Total',
            value: '\$${period.totalPayment.toStringAsFixed(2)}',
            bold: true,
          ),
          _FieldRow(
            label: 'Saldo Final',
            value: '\$${period.finalBalance.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }
}

class _BalloonHeader extends StatelessWidget {
  final int periodNumber;
  final DateTime paymentDate;

  const _BalloonHeader({
    required this.periodNumber,
    required this.paymentDate,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${paymentDate.day.toString().padLeft(2, '0')}/'
        '${paymentDate.month.toString().padLeft(2, '0')}/'
        '${paymentDate.year}';

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$periodNumber',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          dateStr,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'CUOTA BALÓN',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _FieldRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _FieldRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
