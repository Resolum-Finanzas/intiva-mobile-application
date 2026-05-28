/// Base class for all events handled by [SignupBloc].
abstract class SignupEvent {
  const SignupEvent();
}

/// Dispatched when the user submits the registration form.
class Signup extends SignupEvent {
  const Signup();
}

/// Dispatched when the username field value changes.
class OnUsernameChanged extends SignupEvent {
  /// The new username value.
  final String username;
  const OnUsernameChanged({required this.username});
}

/// Dispatched when the email field value changes.
class OnEmailChanged extends SignupEvent {
  /// The new email value.
  final String email;
  const OnEmailChanged({required this.email});
}

/// Dispatched when the password field value changes.
class OnPasswordChanged extends SignupEvent {
  /// The new password value.
  final String password;
  const OnPasswordChanged({required this.password});
}

/// Dispatched when the user toggles password visibility.
class TogglePasswordVisibility extends SignupEvent {
  const TogglePasswordVisibility();
}
