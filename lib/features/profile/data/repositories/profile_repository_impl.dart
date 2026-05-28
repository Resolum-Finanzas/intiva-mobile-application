import 'package:intiva_mobile_application/features/profile/data/remote/services/user_service.dart';
import 'package:intiva_mobile_application/features/profile/domain/models/profile.dart';
import 'package:intiva_mobile_application/features/profile/domain/repositories/profile_repository.dart';

/// Concrete implementation of [ProfileRepository] that fetches data from
/// the remote [UserService] and maps the DTO to the domain [Profile] model.
class ProfileRepositoryImpl implements ProfileRepository {
  final UserService _service;

  /// Creates a [ProfileRepositoryImpl] with the given [UserService].
  const ProfileRepositoryImpl(this._service);

  /// Fetches the authenticated user's profile and maps it to [Profile].
  @override
  Future<Profile> getProfile() async {
    final dto = await _service.getUserProfile();
    return Profile(
      id: dto.id,
      username: dto.username,
      roles: dto.roles,
    );
  }
}
