import 'package:intiva_mobile_application/core/enums/status.dart';

/// Represents the state of the signup / registration form.
class SignupState {

  final Status status;
  final String username;
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isEmailValid;
  final bool isPasswordLongEnough;
  final String? message;

  /// Creates a [SignupState].
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

  /// Returns `true` when all required fields are filled and valid.
  bool get isFormValid =>
      username.isNotEmpty &&
      email.isNotEmpty &&
      isEmailValid &&
      isPasswordLongEnough;

  /// Creates a copy of this state with updated fields.
  SignupState copyWith({
    Status? status,
    String? username,
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isEmailValid,
    bool? isPasswordLongEnough,
    String? message,
  }) {
    return SignupState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordLongEnough: isPasswordLongEnough ?? this.isPasswordLongEnough,
      message: message ?? this.message,
    );
  }
}
