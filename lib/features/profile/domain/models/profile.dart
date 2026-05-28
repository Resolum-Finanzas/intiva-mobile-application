/// Represents the authenticated user's profile information.
class Profile {

  final int id;
  final String username;
  final List<String> roles;

  /// Creates a [Profile].
  const Profile({
    required this.id,
    required this.username,
    required this.roles,
  });

  /// Returns the formatted member ID, e.g. #INT-0042.
  String get memberId => '#INT-${id.toString().padLeft(4, '0')}';

  /// Returns two uppercase initials derived from [username].
  String get initials => username.length >= 2
      ? username.substring(0, 2).toUpperCase()
      : username.toUpperCase();
}
