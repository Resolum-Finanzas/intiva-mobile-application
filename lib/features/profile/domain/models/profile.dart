class Profile {
  final int id;
  final String username;
  final List<String> roles;

  const Profile({
    required this.id,
    required this.username,
    required this.roles,
  });

  String get memberId => '#INT-${id.toString().padLeft(4, '0')}';

  String get initials => username.length >= 2
      ? username.substring(0, 2).toUpperCase()
      : username.toUpperCase();
}
