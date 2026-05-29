import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/analytics/domain/models/simulation_summary.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/history/history_bloc.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/history/history_event.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/history/history_state.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/simulator/simulator_bloc.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/simulator/simulator_event.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/simulator/simulator_state.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';

class SimulationHistoryPage extends StatelessWidget {
  final int userId;

  const SimulationHistoryPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<HistoryBloc>()..add(LoadHistory(userId)),
        ),
        BlocProvider(
          create: (_) => getIt<SimulatorBloc>(),
        ),
      ],
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SimulatorBloc, SimulatorState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          // Reload history after a successful deletion.
          // userId is not available here; the parent page should handle reload.
        }
        if (state.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'Error al eliminar la simulación'),
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
            'Mis Simulaciones',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.initial => const SizedBox.shrink(),
              Status.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
              Status.failure => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 8),
                      IntivaText.body(
                        state.message ?? 'Ocurrió un error',
                      ),
                    ],
                  ),
                ),
              Status.success => state.simulations.isEmpty
                  ? const _EmptyState()
                  : _SimulationList(simulations: state.simulations),
            };
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calculate_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          IntivaText.subtitle(
            'No tienes simulaciones aún',
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _SimulationList extends StatelessWidget {
  final List<SimulationSummary> simulations;

  const _SimulationList({required this.simulations});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: simulations.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final sim = simulations[index];
        return Dismissible(
          key: ValueKey(sim.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete_outline, color: Colors.white),
          ),
          confirmDismiss: (_) async {
            return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Eliminar simulación'),
                content: const Text(
                  '¿Estás seguro de que deseas eliminar esta simulación? '
                  'Esta acción no se puede deshacer.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.error,
                    ),
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) {
            context
                .read<SimulatorBloc>()
                .add(DeleteSimulation(sim.id));
          },
          child: _SimulationSummaryCard(simulation: sim),
        );
      },
    );
  }
}

class _SimulationSummaryCard extends StatelessWidget {
  final SimulationSummary simulation;

  const _SimulationSummaryCard({required this.simulation});

  @override
  Widget build(BuildContext context) {
    final createdStr =
        '${simulation.createdAt.day.toString().padLeft(2, '0')}/'
        '${simulation.createdAt.month.toString().padLeft(2, '0')}/'
        '${simulation.createdAt.year}';

    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  simulation.vehicleName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Text(
                createdStr,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Monto Financiado',
            value: '\$${simulation.financedAmount.toStringAsFixed(2)}',
          ),
          _InfoRow(
            label: 'TEA',
            value: '${simulation.teaPercentage.toStringAsFixed(2)}%',
          ),
          _InfoRow(
            label: 'Plazo',
            value: '${simulation.termMonths} meses',
          ),
          _InfoRow(
            label: 'Cuota Est.',
            value:
                '\$${simulation.estimatedMonthlyPayment.toStringAsFixed(2)}',
            bold: true,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _InfoRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
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
