import 'package:intiva_mobile_application/core/enums/status.dart';

class LoginState {
  final Status status;
  final String email;
  final String password;
  final bool isPasswordVisible;
  final String? message;

  const LoginState({
    this.status = Status.initial,
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.message,
  });

  static const _absent = Object();

  LoginState copyWith({
    Status? status,
    String? email,
    String? password,
    bool? isPasswordVisible,
    Object? message = _absent,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      message: message == _absent ? this.message : message as String?,
    );
  }
}
