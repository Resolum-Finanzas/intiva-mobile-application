abstract class SignupEvent {
  const SignupEvent();
}

class Signup extends SignupEvent {
  const Signup();
}

class OnUsernameChanged extends SignupEvent {
  final String username;
  const OnUsernameChanged({required this.username});
}

class OnEmailChanged extends SignupEvent {
  final String email;
  const OnEmailChanged({required this.email});
}

class OnPasswordChanged extends SignupEvent {
  final String password;
  const OnPasswordChanged({required this.password});
}

class TogglePasswordVisibility extends SignupEvent {
  const TogglePasswordVisibility();
}
