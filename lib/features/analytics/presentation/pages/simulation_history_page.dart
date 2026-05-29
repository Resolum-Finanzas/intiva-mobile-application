import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
          create: (_) => getIt<HistoryBloc>()..add(LoadHistory(userId)),
        ),
        BlocProvider(
          create: (_) => getIt<SimulatorBloc>(),
        ),
      ],
      child: _HistoryBody(userId: userId),
    );
  }
}

class _HistoryBody extends StatelessWidget {
  final int userId;

  const _HistoryBody({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SimulatorBloc, SimulatorState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          context.read<HistoryBloc>().add(LoadHistory(userId));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Simulación eliminada'),
              backgroundColor: AppColors.secondary,
              behavior: SnackBarBehavior.floating,
            ),
          );
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
                  : _SimulationList(simulations: state.simulations, userId: userId),
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
  final int userId;

  const _SimulationList({required this.simulations, required this.userId});

  Widget _infoRow(String label, String value, {bool bold = false}) {
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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: simulations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final sim = simulations[index];
        return Dismissible(
          key: ValueKey(sim.id),
          direction: DismissDirection.endToStart,
          background: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.delete_outline, color: Colors.white),
              ),
            ),
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
            context.read<SimulatorBloc>().add(DeleteSimulation(sim.id));
          },
          child: Container(
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
                        sim.vehicleName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(sim.createdAt),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _infoRow('Monto Financiado', '\$${sim.financedAmount.toStringAsFixed(2)}'),
                _infoRow('TEA', '${sim.teaPercentage.toStringAsFixed(2)}%'),
                _infoRow('Plazo', '${sim.termMonths} meses'),
                _infoRow(
                  'Cuota Est.',
                  '\$${sim.estimatedMonthlyPayment.toStringAsFixed(2)}',
                  bold: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
