import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/iam/domain/repositories/auth_repository.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _repository;

  SignupBloc({required AuthRepository repository})
      : _repository = repository,
        super(const SignupState()) {
    on<OnUsernameChanged>(_onUsernameChanged);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<Signup>(_onSignup);
  }

  void _onUsernameChanged(
    OnUsernameChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  void _onEmailChanged(
    OnEmailChanged event,
    Emitter<SignupState> emit,
  ) {
    final isValid =
        RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email);
    emit(state.copyWith(email: event.email, isEmailValid: isValid));
  }

  void _onPasswordChanged(
    OnPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
      isPasswordLongEnough: event.password.length >= 8,
    ));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onSignup(
    Signup event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, message: null));
    try {
      await _repository.signUp(
        state.username,
        state.email,
        state.password,
        'ROLE_USER',
        '',
      );
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
