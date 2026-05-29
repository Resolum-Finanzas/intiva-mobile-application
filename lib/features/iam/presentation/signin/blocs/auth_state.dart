import 'package:intiva_mobile_application/features/iam/domain/models/auth_status.dart';

class AuthState {
  final AuthStatus status;
  final String? message;

  const AuthState({this.status = AuthStatus.initial, this.message});

  bool get isAuthenticated => status == AuthStatus.authenticated;

  static const _absent = Object();

  AuthState copyWith({
    AuthStatus? status,
    Object? message = _absent,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message == _absent ? this.message : message as String?,
    );
  }
}
