import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/profile/domain/models/profile.dart';

/// Represents the state of the profile feature.
class ProfileState {

  final Status status;
  final Profile? profile;
  final String? message;

  /// Creates a [ProfileState].
  const ProfileState({
    this.status = Status.initial,
    this.profile,
    this.message,
  });

  /// Creates a copy of this state with updated fields.
  ProfileState copyWith({
    Status? status,
    Profile? profile,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }
}
