import 'package:intiva_mobile_application/features/iam/domain/models/auth_status.dart';

/// Represents the global authentication state of the application.
class AuthState {

  final AuthStatus status;
  final String? message;

  const AuthState({this.status = AuthStatus.initial, this.message});

  /// Returns `true` when the user is authenticated.
  bool get isAuthenticated => status == AuthStatus.authenticated;

  /// Creates a copy of this state with updated fields.
  AuthState copyWith({AuthStatus? status, String? message}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
