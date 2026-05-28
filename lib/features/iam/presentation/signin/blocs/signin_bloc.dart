import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/iam/domain/repositories/auth_repository.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/signin_event.dart';
import 'package:intiva_mobile_application/features/iam/presentation/signin/blocs/signin_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc({required this.repository}) : super(LoginState()) {
    on<OnEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.email)),
    );
    on<OnPasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );
    on<TogglePasswordVisibility>(
      (event, emit) =>
          emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible)),
    );

    on<Login>(_onLogin);
  }

  FutureOr<void> _onLogin(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await repository.signIn(state.email, state.password);
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
          message: "Login failed. Please check your credentials and try again.",
        ),
      );
    }
  }
}
