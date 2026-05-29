import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/core/navigation/router/router_names.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';
import 'package:intiva_mobile_application/features/iam/domain/models/auth_status.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/auth_bloc.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/auth_event.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/auth_state.dart';
import 'package:intiva_mobile_application/features/profile/domain/models/profile.dart';
import 'package:intiva_mobile_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:intiva_mobile_application/features/profile/presentation/bloc/profile_event.dart';
import 'package:intiva_mobile_application/features/profile/presentation/bloc/profile_state.dart';
import 'package:intiva_mobile_application/features/shared/presentation/widgets/intiva_text.dart';

class ProfilePage extends StatelessWidget {
  final int userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(LoadProfile(userId)),
      child: _ProfileView(userId: userId),
    );
  }
}

class _ProfileView extends StatelessWidget {
  final int userId;

  const _ProfileView({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial:
              return const SizedBox.shrink();
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            case Status.failure:
              return _ErrorView(
                message: state.message ?? 'Ocurrió un error',
                onRetry: () => context.read<ProfileBloc>().add(LoadProfile(userId)),
              );
            case Status.success:
              return _ProfileBody(profile: state.profile!);
          }
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final Profile profile;

  const _ProfileBody({required this.profile});

  Widget _profileMenuItem(
    IconData icon,
    String label, {
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final primary = Theme.of(context).colorScheme.primary;
        return ListTile(
          leading: DecoratedBox(
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: primary, size: 20),
            ),
          ),
          title: IntivaText.body(label),
          trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey[400]),
          onTap: onTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Perfil',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 36,
            backgroundColor: primary,
            child: IntivaText.subtitle(profile.initials, color: Colors.white),
          ),
          const SizedBox(height: 12),
          IntivaText.subtitle(profile.username),
          IntivaText.body('Cuenta Personal', color: Colors.grey[600]),
          const SizedBox(height: 24),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[300]!, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _profileMenuItem(
                  Icons.badge_outlined,
                  'ID de Miembro',
                  trailing: IntivaText.caption(profile.memberId, color: Colors.grey[600]),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56),
                _profileMenuItem(
                  Icons.settings_outlined,
                  'Configuración',
                  onTap: () => context.push(RouteNames.settings),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56),
                _profileMenuItem(
                  Icons.shield_outlined,
                  'Privacidad y Seguridad',
                  onTap: () => context.push(RouteNames.placeholder),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56),
                _profileMenuItem(
                  Icons.help_outline,
                  'Centro de Ayuda',
                  onTap: () => context.push(RouteNames.placeholder),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.unauthenticated) {
                context.go(RouteNames.signIn);
              }
            },
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red[700], size: 22),
                title: IntivaText.body('Cerrar Sesión', color: Colors.red[700]),
                onTap: () => context.read<AuthBloc>().add(const SignOut()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 8),
          IntivaText.body(message),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
