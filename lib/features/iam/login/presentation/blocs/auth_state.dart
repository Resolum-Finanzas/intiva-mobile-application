import 'package:intiva_mobile_application/features/iam/login/domain/models/auth_status.dart';

class AuthState {
  final AuthStatus status;

  const AuthState({this.status = AuthStatus.initial});

  AuthState copyWith({AuthStatus? status}) {
    return AuthState(status: status ?? this.status);
  }
}
