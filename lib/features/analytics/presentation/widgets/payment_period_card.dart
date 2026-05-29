import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/payment_period.dart';

class PaymentPeriodCard extends StatelessWidget {
  final PaymentPeriod period;

  const PaymentPeriodCard({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PeriodHeader(
            periodNumber: period.periodNumber,
            paymentDate: period.paymentDate,
            isGracePeriod: period.isGracePeriod,
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
            label: 'Cuota Mensual',
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

class _PeriodHeader extends StatelessWidget {
  final int periodNumber;
  final DateTime paymentDate;
  final bool isGracePeriod;

  const _PeriodHeader({
    required this.periodNumber,
    required this.paymentDate,
    required this.isGracePeriod,
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
            color: AppColors.primary,
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
        if (isGracePeriod)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.tertiary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'GRACIA',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
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
