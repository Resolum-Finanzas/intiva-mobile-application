import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/auth_bloc.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/auth_event.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/signin_bloc.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/pages/signin_page.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signup/blocs/signup_bloc.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signup/pages/signup_page.dart';
import 'package:intiva_mobile_application/features/profile/presentation/pages/profile_page.dart';
import 'package:intiva_mobile_application/features/shared/presentation/pages/configuration_page.dart';
import '../router/auth_guard.dart';
import '../router/router_names.dart';
import '../../../features/shared/presentation/pages/placeholder_page.dart';
import '../../navigation/widgets/app_bottom_nav.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/analytics/domain/models/loan_simulation.dart';
import '../../../features/analytics/presentation/pages/simulator_page.dart';
import '../../../features/analytics/presentation/pages/payment_plan_page.dart';
import '../../../features/analytics/presentation/pages/simulation_history_page.dart';
import '../../../features/catalog/presentation/pages/catalog_page.dart';
import '../../../features/catalog/presentation/pages/vehicle_detail_page.dart';
import '../../../features/communication/presentation/pages/notifications_page.dart';


class AppRouter {
  final AuthGuard _authGuard;
  AppRouter(this._authGuard);
  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.home,
    redirect: _authGuard.redirect,
    routes: [
      GoRoute(
        path: RouteNames.signIn,
        builder: (context, _) => BlocProvider(
          create: (_) => getIt<LoginBloc>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.signUp,
        builder: (context, _) => BlocProvider(
          create: (_) => getIt<SignupBloc>(),
          child: const RegisterPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(const AppStarted()),
          child: Scaffold(body: AppBottomNav(child: child)),
        ),
        routes: [
          GoRoute(
            path: RouteNames.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: RouteNames.catalog,
            builder: (context, state) => const CatalogPage(),
            routes: [
              GoRoute(
                path: ':vehicleId',
                builder: (context, state) => VehicleDetailPage(
                  vehicleId: state.pathParameters['vehicleId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.simulator,
            builder: (context, state) {
              final extras = state.extra as Map<String, dynamic>;
              return SimulatorPage(
                vehicleId: extras['vehicleId'] as String,
                vehicleName: extras['vehicleName'] as String,
                vehiclePrice: extras['vehiclePrice'] as double,
              );
            },
            routes: [
              GoRoute(
                path: 'schedule',
                builder: (context, state) {
                  final simulation = state.extra as LoanSimulation;
                  return PaymentPlanPage(simulation: simulation);
                },
              ),
              GoRoute(
                path: 'history',
                builder: (context, state) {
                  final extras = state.extra as Map<String, dynamic>;
                  return SimulationHistoryPage(
                    userId: extras['userId'] as int,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.settings,
            builder: (context, state) => const ConfigurationPage(),
          ),
          GoRoute(
            path: RouteNames.profile,
            builder: (context, state) {
              final userId =
                  (state.extra as Map<String, dynamic>?)?['userId'] as int? ??
                      1;
              return ProfilePage(userId: userId);
            },
          ),
          GoRoute(
            path: RouteNames.notifications,
            builder: (context, state) {
              final userId =
                  (state.extra as Map<String, dynamic>?)?['userId'] as int? ??
                      1;
              return NotificationsPage(userId: userId);
            },
          ),
          GoRoute(
            path: RouteNames.placeholder,
            builder: (context, state) =>
                const PlaceholderPage(name: 'Próximamente'),
          ),
        ],
      ),
    ],
  );
}
