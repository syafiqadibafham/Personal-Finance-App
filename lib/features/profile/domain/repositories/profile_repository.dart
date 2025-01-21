import 'package:personal_finance_app/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepository {
  Future<ProfileUser?> getProfile(String id);

  Future<void> updateProfile(ProfileUser updatedProfileUser);
}
