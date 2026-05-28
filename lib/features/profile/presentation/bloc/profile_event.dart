/// Base class for all events handled by [ProfileBloc].
abstract class ProfileEvent {
  const ProfileEvent();
}

/// Event dispatched to load the profile for the given [userId].
class LoadProfile extends ProfileEvent {
  /// The identifier of the user whose profile should be loaded.
  final int userId;

  /// Creates a [LoadProfile] event.
  const LoadProfile(this.userId);
}
