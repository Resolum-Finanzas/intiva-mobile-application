import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_bloc.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_event.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_state.dart';
import 'package:intiva_mobile_application/features/iam/login/presentation/blocs/login_bloc.dart';

/// Outlined button that dispatches [SendSimulationReport] to [NotificationBloc].
///
/// Reads the recipient email from [LoginBloc] state — no extra API call needed.
/// Shows a [CircularProgressIndicator] while loading and a [SnackBar] on
/// success or failure.
///
/// Place this widget inside a [BlocProvider<NotificationBloc>] scope, typically
/// at the bottom of [PaymentPlanPage].
class SendReportButton extends StatelessWidget {
  /// The ID of the simulation whose report will be sent.
  final String simulationId;

  /// Creates a [SendReportButton].
  const SendReportButton({super.key, required this.simulationId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listenWhen: (prev, curr) =>
          curr is NotificationSuccess || curr is NotificationError,
      listener: (context, state) {
        if (state is NotificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.accent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is NotificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is NotificationLoading;

        return SizedBox(
          width: double.infinity,
          height: 44,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
                    final email =
                        context.read<LoginBloc>().state.email;
                    context.read<NotificationBloc>().add(
                          SendSimulationReport(
                            simulationId: simulationId,
                            recipientEmail: email,
                          ),
                        );
                  },
            icon: isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : const Icon(Icons.mail_outline, size: 18),
            label: const Text(
              'Enviar reporte por correo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
