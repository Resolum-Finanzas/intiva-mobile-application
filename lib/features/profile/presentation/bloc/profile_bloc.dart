import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/profile/domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

/// BLoC that manages the profile feature state.
///
/// Handles [LoadProfile] by fetching the user's profile from [ProfileRepository].
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  /// Creates a [ProfileBloc] with the given [ProfileRepository].
  ProfileBloc(this._repository) : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
  }

  /// Handles [LoadProfile]: emits loading, then success or failure.
  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState(status: Status.loading));
    try {
      final profile = await _repository.getProfile();
      emit(ProfileState(status: Status.success, profile: profile));
    } catch (e) {
      emit(ProfileState(status: Status.failure, message: e.toString()));
    }
  }
}
