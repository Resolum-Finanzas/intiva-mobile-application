/// Base class for all events handled by [AuthBloc].
abstract class AuthEvent {
  const AuthEvent();
}

/// Dispatched on app launch to check whether a valid token exists.
class AppStarted extends AuthEvent {
  const AppStarted();
}

/// Dispatched to sign the current user out and clear stored credentials.
class SignOut extends AuthEvent {
  const SignOut();
}

/// Dispatched to register a new user account.
class SignUp extends AuthEvent {
  final String username;
  final String password;
  final List<String> roles;

  /// Creates a [SignUp] event.
  const SignUp({
    required this.username,
    required this.password,
    required this.roles,
  });
}
