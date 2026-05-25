import 'package:go_router/go_router.dart';
import '../router/auth_guard.dart';
import '../router/router_names.dart';
import '../../../features/shared/presentation/pages/placeholder_page.dart';
import '../../navigation/widgets/app_bottom_nav.dart';
import '../../../features/iam/login/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/di/injection.dart';
import 'package:intiva_mobile_application/features/iam/login/presentation/blocs/login_bloc.dart';
import '../../../features/catalog/presentation/pages/catalog_page.dart';

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
        builder: (_, _) => const CatalogPage(),
      ),
      ShellRoute(
        builder: (_, _, child) => AppBottomNav(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            builder: (_, _) => const PlaceholderPage(name: 'Inicio'),
          ),
          GoRoute(
            path: RouteNames.catalog,
            builder: (_, _) => const CatalogPage(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (_, state) =>
                    PlaceholderPage(name: 'Detalle del auto'),
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.simulator,
            builder: (_, _) => const PlaceholderPage(name: 'Simulador'),
            routes: [
              GoRoute(
                path: 'schedule',
                builder: (_, state) =>
                    PlaceholderPage(name: 'Programación de pagos'),
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.settings,
            builder: (_, _) => const PlaceholderPage(name: 'Configuración'),
          ),
          GoRoute(
            path: RouteNames.profile,
            builder: (_, _) => const PlaceholderPage(name: 'Perfil'),
          ),
        ],
      ),
    ],
  );
}
