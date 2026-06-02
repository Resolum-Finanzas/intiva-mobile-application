abstract class AuthEvent {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  const AppStarted();
}

class SignOut extends AuthEvent {
  const SignOut();
}

class SignUp extends AuthEvent {
  final String username;
  final String password;
  final List<String> roles;

  const SignUp({
    required this.username,
    required this.password,
    required this.roles,
  });
}
