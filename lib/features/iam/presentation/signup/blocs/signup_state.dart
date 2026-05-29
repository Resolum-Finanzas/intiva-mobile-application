import 'package:intiva_mobile_application/core/enums/status.dart';

class SignupState {
  final Status status;
  final String username;
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isEmailValid;
  final bool isPasswordLongEnough;
  final String? message;

  const SignupState({
    this.status = Status.initial,
    this.username = '',
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isEmailValid = true,
    this.isPasswordLongEnough = false,
    this.message,
  });

  bool get isFormValid =>
      username.isNotEmpty &&
      email.isNotEmpty &&
      isEmailValid &&
      isPasswordLongEnough;

  static const _absent = Object();

  SignupState copyWith({
    Status? status,
    String? username,
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isEmailValid,
    bool? isPasswordLongEnough,
    Object? message = _absent,
  }) {
    return SignupState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordLongEnough: isPasswordLongEnough ?? this.isPasswordLongEnough,
      message: message == _absent ? this.message : message as String?,
    );
  }
}
