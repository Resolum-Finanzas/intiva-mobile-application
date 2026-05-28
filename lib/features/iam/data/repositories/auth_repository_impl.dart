import 'package:intiva_mobile_application/core/network/api/resource.dart';
import 'package:intiva_mobile_application/core/storage/token_storage.dart';
import 'package:intiva_mobile_application/features/iam/domain/repositories/auth_repository.dart';
import 'package:intiva_mobile_application/features/iam/data/services/remote/auth_service.dart';
import 'package:intiva_mobile_application/features/iam/domain/models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;
  final TokenStorage tokenStorage;

  const AuthRepositoryImpl({required this.service, required this.tokenStorage});

  @override
  Future<User> signIn(String username, String password) async {
    final user = await service.login(username, password);
    await tokenStorage.delete();
    await tokenStorage.save(user.token);
    return user;
  }

  @override
  Future<Resource<String>> signUp(
    String username,
    String email,
    String password,
    String accountRole,
    String businessName,
  ) async {
    return service.register(
      username,
      email,
      password,
      accountRole,
      businessName,
    );
  }
}
