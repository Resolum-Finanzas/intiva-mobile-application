import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/storage/token_storage.dart';
import 'package:intiva_mobile_application/features/iam/domain/models/auth_status.dart';
import 'package:intiva_mobile_application/features/iam/domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC that manages the global authentication state of the application.
///
/// Handles [AppStarted] (token check on launch), [SignUp] (registration),
/// and [SignOut] (logout + token deletion).
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenStorage _tokenStorage;
  final AuthRepository _authRepository;

  /// Creates an [AuthBloc] with the required [tokenStorage] and [authRepository].
  AuthBloc({
    required TokenStorage tokenStorage,
    required AuthRepository authRepository,
  })  : _tokenStorage = tokenStorage,
        _authRepository = authRepository,
        super(const AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<SignOut>(_onSignOut);
    on<SignUp>(_onSignUp);
  }

  /// Checks for a stored token and emits [authenticated] or [unauthenticated].
  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    final token = await _tokenStorage.read();
    emit(
      state.copyWith(
        status: token != null
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
      ),
    );
  }

  /// Deletes the stored token and emits [unauthenticated].
  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    await _tokenStorage.delete();
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  /// Calls the repository to register a new user.
  ///
  /// Emits [loading] → [authenticated] on success, or [error] on failure.
  Future<void> _onSignUp(
    SignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.signUp(
        event.username,
        '',
        event.password,
        event.roles.isNotEmpty ? event.roles.first : 'ROLE_USER',
        '',
      );
      emit(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        message: e.toString(),
      ));
    }
  }
}
