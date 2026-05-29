import 'package:flutter/material.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

class CreditConfigSection extends StatelessWidget {
  final String paymentFrequency;
  final int termMonths;
  final double balloonPaymentPercentage;
  final ValueChanged<String?> onFrequencyChanged;
  final ValueChanged<int?> onTermChanged;
  final ValueChanged<String> onBalloonChanged;

  static const _frequencies = ['Mensual'];
  static const _terms = [24, 36];

  const CreditConfigSection({
    super.key,
    required this.paymentFrequency,
    required this.termMonths,
    required this.balloonPaymentPercentage,
    required this.onFrequencyChanged,
    required this.onTermChanged,
    required this.onBalloonChanged,
  });

  Widget _labeledDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          initialValue: value,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(itemLabel(item)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _labeledTextField({
    required String label,
    String? initialValue,
    required TextInputType keyboardType,
    String? hint,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.settings, size: 16, color: AppColors.primary),
            const SizedBox(width: 6),
            const Text(
              'Configuración del Crédito',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const Divider(height: 20),
        Row(
          children: [
            Expanded(
              child: _labeledDropdown<String>(
                label: 'Frecuencia de Pago',
                value: paymentFrequency,
                items: _frequencies,
                itemLabel: (v) => v,
                onChanged: onFrequencyChanged,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _labeledDropdown<int>(
                label: 'Plazo del Crédito',
                value: termMonths,
                items: _terms,
                itemLabel: (v) => '$v meses',
                onChanged: onTermChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _labeledTextField(
          label: 'Cuota Balloon (%)',
          initialValue: balloonPaymentPercentage == 0
              ? ''
              : balloonPaymentPercentage.toStringAsFixed(2),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          hint: 'Ej. 30.00',
          onChanged: onBalloonChanged,
        ),
      ],
    );
  }
}
