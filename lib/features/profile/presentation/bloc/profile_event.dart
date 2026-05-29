abstract class ProfileEvent {
  const ProfileEvent();
}

class LoadProfile extends ProfileEvent {
  final int userId;

  const LoadProfile(this.userId);
}
