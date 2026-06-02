import 'package:intiva_mobile_application/core/enums/status.dart';
import 'package:intiva_mobile_application/features/profile/domain/models/profile.dart';

class ProfileState {
  final Status status;
  final Profile? profile;
  final String? message;

  const ProfileState({
    this.status = Status.initial,
    this.profile,
    this.message,
  });

  static const _absent = Object();

  ProfileState copyWith({
    Status? status,
    Profile? profile,
    Object? message = _absent,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      message: message == _absent ? this.message : message as String?,
    );
  }
}
