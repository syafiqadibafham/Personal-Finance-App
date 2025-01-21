import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_finance_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:personal_finance_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:personal_finance_app/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'package:personal_finance_app/features/profile/domain/entities/profile_user.dart';
import 'package:personal_finance_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthLocalDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<ProfileUser?> getProfile(String id) async {
    try {
      final userDoc = await firestore.collection('users').doc(id).get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data();

      if (userData == null) return null;

      localDataSource.write(key: 'user', value: userData);

      return ProfileUser.fromMap(userData);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfileUser) async {
    try {
      await firestore.collection('users').doc(updatedProfileUser.id).update(updatedProfileUser.toMap());
    } catch (e) {}
  }
}
