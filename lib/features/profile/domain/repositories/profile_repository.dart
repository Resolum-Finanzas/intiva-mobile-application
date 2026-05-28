import 'package:intiva_mobile_application/features/profile/domain/models/profile.dart';

/// Abstract contract for fetching the authenticated user's profile.
abstract class ProfileRepository {
  /// Returns the profile of the currently authenticated user.
  Future<Profile> getProfile();
}
