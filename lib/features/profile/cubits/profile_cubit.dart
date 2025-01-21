import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/profile/cubits/profile_state.dart';
import 'package:personal_finance_app/features/profile/domain/entities/profile_user.dart';
import 'package:personal_finance_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());

  Future<void> getProfile(String id) async {
    emit(ProfileLoading());
    try {
      final profileUser = await profileRepository.getProfile(id);

      if (profileUser == null) {
        emit(ProfileError(message: 'User not found'));
        return;
      }
      emit(ProfileLoaded(profileUser: profileUser));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfile({required String id, String? name, String? profileImageUrl}) async {
    emit(ProfileLoading());
    try {
      final profileUser = await profileRepository.getProfile(id);
      if (profileUser == null) {
        emit(ProfileError(message: 'User not found'));
        return;
      }
      final updatedProfileUser = profileUser.copyWith(name: name, profileImageUrl: profileImageUrl);
      await profileRepository.updateProfile(updatedProfileUser);

      await getProfile(id);
      emit(ProfileLoaded(profileUser: updatedProfileUser));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
