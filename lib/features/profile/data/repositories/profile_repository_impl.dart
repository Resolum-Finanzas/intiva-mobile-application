import 'package:intiva_mobile_application/features/profile/data/remote/services/user_service.dart';
import 'package:intiva_mobile_application/features/profile/domain/models/profile.dart';
import 'package:intiva_mobile_application/features/profile/domain/repositories/profile_repository.dart';

/// [ProfileRepository] backed by [UserService].
class ProfileRepositoryImpl implements ProfileRepository {
  final UserService _service;

  const ProfileRepositoryImpl(this._service);

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
