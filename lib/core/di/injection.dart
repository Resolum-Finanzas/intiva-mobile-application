import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intiva_mobile_application/core/network/client/dio_client.dart';
import 'package:intiva_mobile_application/core/network/interceptor/auth_interceptor.dart';
import 'package:intiva_mobile_application/core/navigation/router/app_router.dart';
import 'package:intiva_mobile_application/core/navigation/router/auth_guard.dart';
import 'package:intiva_mobile_application/core/storage/token_storage.dart';
import 'package:intiva_mobile_application/features/iam/login/domain/repositories/auth_repository.dart';
import 'package:intiva_mobile_application/features/iam/login/data/repositories/auth_repository_impl.dart';
import 'package:intiva_mobile_application/features/iam/login/data/services/remote/auth_service.dart';
import 'package:intiva_mobile_application/features/iam/login/presentation/blocs/login_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Storage
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  // Network
  getIt.registerSingleton<AuthInterceptor>(
    AuthInterceptor(getIt<FlutterSecureStorage>()),
  );
  getIt.registerSingleton<DioClient>(DioClient(getIt<AuthInterceptor>()));

  // Router
  getIt.registerSingleton<AuthGuard>(AuthGuard(getIt<FlutterSecureStorage>()));
  getIt.registerSingleton<AppRouter>(AppRouter(getIt<AuthGuard>()));

  // Storage helper
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
}
