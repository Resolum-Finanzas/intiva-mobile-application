import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/iam/domain/repositories/auth_repository.dart';
import 'signup_event.dart';
import 'signup_state.dart';

/// BLoC that manages the signup / registration form state.
///
/// Handles field-change events for live validation and [Signup] to submit
/// the registration request via [AuthRepository].
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _repository;

  /// Creates a [SignupBloc] with the given [AuthRepository].
  SignupBloc({required AuthRepository repository})
      : _repository = repository,
        super(const SignupState()) {
    on<OnUsernameChanged>(_onUsernameChanged);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<Signup>(_onSignup);
  }

  /// Updates [SignupState.username].
  void _onUsernameChanged(
    OnUsernameChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  /// Updates [SignupState.email] and validates its format.
  void _onEmailChanged(
    OnEmailChanged event,
    Emitter<SignupState> emit,
  ) {
    final isValid =
        RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email);
    emit(state.copyWith(email: event.email, isEmailValid: isValid));
  }

  /// Updates [SignupState.password] and validates its length.
  void _onPasswordChanged(
    OnPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
      isPasswordLongEnough: event.password.length >= 8,
    ));
  }

  /// Flips [SignupState.isPasswordVisible].
  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  /// Submits the registration form.
  ///
  /// Emits [Status.loading] → [Status.success] on success,
  /// or [Status.failure] with an error message on failure.
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
