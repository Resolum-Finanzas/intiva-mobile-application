import 'package:intiva_mobile_application/core/network/api/resource.dart';
import 'package:intiva_mobile_application/features/iam/domain/models/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String username, String password);

  Future<Resource<String>> signUp(
    String username,
    String email,
    String password,
    String accountRole,
    String businessName,
  );
}
