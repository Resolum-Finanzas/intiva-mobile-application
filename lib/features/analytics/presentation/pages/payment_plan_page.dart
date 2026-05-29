import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/loan_simulation.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/widgets/balloon_period_card.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/widgets/financial_metrics_card.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/widgets/payment_period_card.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_bloc.dart';
import 'package:intiva_mobile_application/features/communication/presentation/widgets/send_report_button.dart';

class PaymentPlanPage extends StatelessWidget {
  final LoanSimulation simulation;

  const PaymentPlanPage({super.key, required this.simulation});

  @override
  Widget build(BuildContext context) {
    final schedule = simulation.schedule;

    return BlocProvider(
      create: (_) => getIt<NotificationBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.neutral,
        body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monto a Financiar',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$${simulation.financedAmount.toStringAsFixed(2)} USD',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'WorkSans',
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FinancialMetricsCard(simulation: simulation),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Text(
                'Detalle de Cuotas — ${simulation.termMonths} Meses',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),

          if (schedule == null)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'El cronograma no está disponible.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final period = schedule.periods[index];
                  return period.isBalloon
                      ? BalloonPeriodCard(period: period)
                      : PaymentPeriodCard(period: period);
                },
                childCount: schedule.periods.length,
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SendReportButton(simulationId: simulation.id),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    ),
  );
  }
}
