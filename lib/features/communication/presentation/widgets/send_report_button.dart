import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_bloc.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_event.dart';
import 'package:intiva_mobile_application/features/communication/presentation/bloc/notification_state.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/signin_bloc.dart';

class SendReportButton extends StatelessWidget {
  final String simulationId;

  const SendReportButton({super.key, required this.simulationId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listenWhen: (prev, curr) =>
          curr.status == Status.success || curr.status == Status.failure,
      listener: (context, state) {
        if (state.status == Status.success && state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.accent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'An error occurred.'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == Status.loading;

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
                    final email = context.read<LoginBloc>().state.email;
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
