import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/core/navigation/router/router_names.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_parameters.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/simulator/simulator_bloc.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/simulator/simulator_event.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/simulator/simulator_state.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/widgets/bank_selector.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/widgets/credit_config_section.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/widgets/grace_period_section.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/widgets/vehicle_price_header.dart';

class SimulatorPage extends StatelessWidget {
  final String vehicleId;
  final String vehicleName;
  final double vehiclePrice;

  const SimulatorPage({
    super.key,
    required this.vehicleId,
    required this.vehicleName,
    required this.vehiclePrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SimulatorBloc>()
        ..add(LoadSimulator(
          vehicleId: vehicleId,
          vehicleName: vehicleName,
          vehiclePrice: vehiclePrice,
        )),
      child: _SimulatorView(
        vehicleId: vehicleId,
        vehicleName: vehicleName,
        vehiclePrice: vehiclePrice,
      ),
    );
  }
}


class _SimulatorView extends StatefulWidget {
  final String vehicleId;
  final String vehicleName;
  final double vehiclePrice;

  const _SimulatorView({
    required this.vehicleId,
    required this.vehicleName,
    required this.vehiclePrice,
  });

  @override
  State<_SimulatorView> createState() => _SimulatorViewState();
}

class _SimulatorViewState extends State<_SimulatorView> {

  double _initialPaymentPct = 20;
  String _selectedBank = 'BCP';
  double _teaPercentage = 12.0;
  String _paymentFrequency = 'Mensual';
  int _termMonths = 24;
  double _balloonPaymentPct = 0;
  bool _vehicularInsuranceEnabled = false;
  double _vehicularInsuranceRate = 4.86;
  bool _desgravamenEnabled = false;
  bool _gracePeriodEnabled = false;
  String _gracePeriodType = 'Total';
  int _gracePeriodMonths = 0;
  DateTime _loanStartDate = DateTime.now();
  double get _downPaymentAmount =>
      widget.vehiclePrice * (_initialPaymentPct / 100);

  double get _financedAmount =>
      widget.vehiclePrice * (1 - _initialPaymentPct / 100);
  static const _insuranceRates = {
    'Bajo Riesgo 1': 4.86,
    'Bajo Riesgo 2': 5.85,
    'Riesgo Medio': 6.50,
    'Riesgo Alto': 7.25,
  };

  String get _selectedInsuranceLabel => _insuranceRates.entries
      .firstWhere(
        (e) => e.value == _vehicularInsuranceRate,
        orElse: () => _insuranceRates.entries.first,
      )
      .key;

  InputDecoration _inputDecoration(String label, {String? hint}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      );

  void _onCalculate() {
    final params = LoanParameters(
      vehicleId: widget.vehicleId,
      vehicleName: widget.vehicleName,
      vehiclePrice: widget.vehiclePrice,
      initialPaymentPercentage: _initialPaymentPct,
      bankEntity: _selectedBank,
      teaPercentage: _teaPercentage,
      termMonths: _termMonths,
      balloonPaymentPercentage: _balloonPaymentPct,
      vehicularInsuranceEnabled: _vehicularInsuranceEnabled,
      vehicularInsuranceRate: _vehicularInsuranceRate,
      desgravamenInsuranceEnabled: _desgravamenEnabled,
      gracePeriodEnabled: _gracePeriodEnabled,
      gracePeriodType: _gracePeriodEnabled ? _gracePeriodType : null,
      gracePeriodMonths: _gracePeriodEnabled ? _gracePeriodMonths : null,
      loanStartDate: _loanStartDate,
    );
    context.read<SimulatorBloc>().add(CalculateSchedule(params));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _loanStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _loanStartDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SimulatorBloc, SimulatorState>(
      listener: (context, state) {
        if (state.status == Status.success && state.simulation != null) {
          context.push(
            RouteNames.simulatorSchedule,
            extra: state.simulation,
          );
        }
        if (state.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'Error al calcular el cronograma'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.neutral,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          title: const Text(
            'Simulador de Crédito',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          elevation: 0,
        ),
        body: BlocBuilder<SimulatorBloc, SimulatorState>(
          builder: (context, state) {
            final isLoading = state.status == Status.loading;

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VehiclePriceHeader(
                        vehiclePrice: widget.vehiclePrice,
                        vehicleName: widget.vehicleName,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue:
                                        _initialPaymentPct.toStringAsFixed(0),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    decoration: _inputDecoration(
                                      'Cuota Inicial (%)',
                                    ),
                                    onChanged: (v) {
                                      final parsed = double.tryParse(v);
                                      if (parsed != null) {
                                        setState(
                                          () => _initialPaymentPct = parsed,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text:
                                          '\$${_downPaymentAmount.toStringAsFixed(2)}',
                                    ),
                                    decoration: _inputDecoration(
                                      'Monto (USD)',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                text:
                                    '\$${_financedAmount.toStringAsFixed(2)}',
                              ),
                              decoration: _inputDecoration(
                                'Monto a Financiar (USD)',
                              ),
                            ),
                            const SizedBox(height: 20),

                            BankSelector(
                              selectedBank: _selectedBank,
                              onBankSelected: (bank) =>
                                  setState(() => _selectedBank = bank),
                            ),
                            const SizedBox(height: 20),


                            TextFormField(
                              initialValue:
                                  _teaPercentage.toStringAsFixed(2),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: _inputDecoration(
                                'Tasa Efectiva Anual (TEA %)',
                                hint: 'Rango sugerido: 8% – 18%',
                              ),
                              onChanged: (v) {
                                final parsed = double.tryParse(v);
                                if (parsed != null) {
                                  setState(() => _teaPercentage = parsed);
                                }
                              },
                            ),
                            const SizedBox(height: 20),

                            CreditConfigSection(
                              paymentFrequency: _paymentFrequency,
                              termMonths: _termMonths,
                              balloonPaymentPercentage: _balloonPaymentPct,
                              onFrequencyChanged: (v) {
                                if (v != null) {
                                  setState(() => _paymentFrequency = v);
                                }
                              },
                              onTermChanged: (v) {
                                if (v != null) {
                                  setState(() => _termMonths = v);
                                }
                              },
                              onBalloonChanged: (v) {
                                final parsed = double.tryParse(v);
                                if (parsed != null) {
                                  setState(() => _balloonPaymentPct = parsed);
                                }
                              },
                            ),
                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Seguro Vehicular',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Switch(
                                  value: _vehicularInsuranceEnabled,
                                  activeThumbColor: AppColors.accent,
                                  onChanged: (v) => setState(
                                    () => _vehicularInsuranceEnabled = v,
                                  ),
                                ),
                              ],
                            ),
                            if (_vehicularInsuranceEnabled) ...[
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedInsuranceLabel,
                                decoration: _inputDecoration('Nivel de Riesgo'),
                                items: _insuranceRates.keys
                                    .map(
                                      (label) => DropdownMenuItem(
                                        value: label,
                                        child: Text(
                                          '$label — ${_insuranceRates[label]!.toStringAsFixed(2)}%',
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (label) {
                                  if (label != null) {
                                    setState(
                                      () => _vehicularInsuranceRate =
                                          _insuranceRates[label]!,
                                    );
                                  }
                                },
                              ),
                            ],
                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Seguro de Desgravamen',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: _desgravamenEnabled,
                                  activeThumbColor: AppColors.accent,
                                  onChanged: (v) =>
                                      setState(() => _desgravamenEnabled = v),
                                ),
                              ],
                            ),
                            if (_desgravamenEnabled)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'Tasa fija: 0.077% mensual',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),

                            GracePeriodSection(
                              enabled: _gracePeriodEnabled,
                              gracePeriodType: _gracePeriodType,
                              gracePeriodMonths: _gracePeriodMonths,
                              onEnabledChanged: (v) =>
                                  setState(() => _gracePeriodEnabled = v),
                              onTypeChanged: (v) {
                                if (v != null) {
                                  setState(() => _gracePeriodType = v);
                                }
                              },
                              onMonthsChanged: (v) {
                                final parsed = int.tryParse(v);
                                if (parsed != null) {
                                  setState(() => _gracePeriodMonths = parsed);
                                }
                              },
                            ),
                            const SizedBox(height: 16),

                            GestureDetector(
                              onTap: _pickDate,
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text:
                                        '${_loanStartDate.day.toString().padLeft(2, '0')}/'
                                        '${_loanStartDate.month.toString().padLeft(2, '0')}/'
                                        '${_loanStartDate.year}',
                                  ),
                                  decoration: _inputDecoration(
                                    'Fecha de Inicio del Préstamo',
                                  ).copyWith(
                                    suffixIcon: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 18,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: AppColors.neutral,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: isLoading ? null : _onCalculate,
                        child: isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Calcular Cronograma',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
