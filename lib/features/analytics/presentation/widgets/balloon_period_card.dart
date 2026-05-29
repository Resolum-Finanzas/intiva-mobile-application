import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/payment_period.dart';

class BalloonPeriodCard extends StatelessWidget {
  final PaymentPeriod period;

  const BalloonPeriodCard({super.key, required this.period});

  Widget _fieldRow(String label, String value, {bool bold = false}) {
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

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd/MM/yyyy').format(period.paymentDate);

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
          Row(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: Center(
                    child: Text(
                      '${period.periodNumber}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
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
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    'CUOTA BALÓN',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 16),
          _fieldRow('Saldo Inicial', '\$${period.initialBalance.toStringAsFixed(2)}'),
          _fieldRow('Interés', '\$${period.interest.toStringAsFixed(2)}'),
          _fieldRow('Amortización', '\$${period.amortization.toStringAsFixed(2)}'),
          _fieldRow('Pago Final Total', '\$${period.totalPayment.toStringAsFixed(2)}', bold: true),
          _fieldRow('Saldo Final', '\$${period.finalBalance.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
