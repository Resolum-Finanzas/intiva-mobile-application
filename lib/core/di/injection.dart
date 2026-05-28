import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:intiva_mobile_application/core/navigation/router/app_router.dart';
import 'package:intiva_mobile_application/core/navigation/router/auth_guard.dart';
import 'package:intiva_mobile_application/core/network/api/api_endpoints.dart';
import 'package:intiva_mobile_application/core/network/client/dio_client.dart';
import 'package:intiva_mobile_application/core/network/interceptor/auth_interceptor.dart';
import 'package:intiva_mobile_application/core/storage/token_storage.dart';
import 'package:intiva_mobile_application/features/analytics/data/remote/services/loan_simulation_service.dart';
import 'package:intiva_mobile_application/features/analytics/data/repositories/loan_simulation_repository_impl.dart';
import 'package:intiva_mobile_application/features/analytics/domain/repositories/loan_simulation_repository.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/history/history_bloc.dart';
import 'package:intiva_mobile_application/features/analytics/presentation/bloc/simulator/simulator_bloc.dart';
import 'package:intiva_mobile_application/features/catalog/data/repositories/mock_vehicle_repository.dart';
import 'package:intiva_mobile_application/features/catalog/domain/repositories/vehicle_repository.dart';
import 'package:intiva_mobile_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:intiva_mobile_application/features/iam/login/data/repositories/auth_repository_impl.dart';
import 'package:intiva_mobile_application/features/iam/login/data/services/remote/auth_service.dart';
import 'package:intiva_mobile_application/features/iam/login/domain/repositories/auth_repository.dart';
import 'package:intiva_mobile_application/features/iam/login/presentation/blocs/login_bloc.dart';

final getIt = GetIt.instance;

/// Configures all dependencies for the application using GetIt.
Future<void> configureDependencies() async {
  //Storage 
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  //Network
  getIt.registerSingleton<AuthInterceptor>(
    AuthInterceptor(getIt<FlutterSecureStorage>()),
  );
  getIt.registerSingleton<DioClient>(DioClient(getIt<AuthInterceptor>()));

  getIt.registerLazySingleton<TokenStorage>(
    () => TokenStorage(getIt<FlutterSecureStorage>()),
  );

  //IAM
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      service: getIt<AuthService>(),
      tokenStorage: getIt<TokenStorage>(),
    ),
  );
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(repository: getIt<AuthRepository>()),
  );

  //Catalog
  getIt.registerLazySingleton<VehicleRepository>(
    // TODO: swap to VehicleRepositoryImpl when the backend is ready.
    () => MockVehicleRepository(),
  );
  getIt.registerFactory<CatalogBloc>(
    () => CatalogBloc(getIt<VehicleRepository>()),
  );

  //Analytics
  getIt.registerLazySingleton<LoanSimulationService>(
    () => LoanSimulationService(
      getIt<DioClient>().dio,
      baseUrl: ApiEndpoints.baseUrl,
    ),
  );
  getIt.registerLazySingleton<LoanSimulationRepository>(
    () => LoanSimulationRepositoryImpl(getIt<LoanSimulationService>()),
  );
  getIt.registerFactory<SimulatorBloc>(
    () => SimulatorBloc(getIt<LoanSimulationRepository>()),
  );
  getIt.registerFactory<HistoryBloc>(
    () => HistoryBloc(getIt<LoanSimulationRepository>()),
  );

  //Router
  getIt.registerSingleton<AuthGuard>(AuthGuard(getIt<FlutterSecureStorage>()));
  getIt.registerSingleton<AppRouter>(AppRouter(getIt<AuthGuard>()));
}
