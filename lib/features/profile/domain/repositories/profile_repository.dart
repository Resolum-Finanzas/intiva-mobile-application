import 'package:intiva_mobile_application/features/profile/domain/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
}
