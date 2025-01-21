import 'dart:developer';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<AuthUser> get authUser {
    return remoteDataSource.user.map((authUserModel) {
      // if (authUserModel != null) {
      //   localDataSource.write(key: 'user', value: authUserModel);
      // } else {
      //   localDataSource.write(key: 'user', value: null);
      // }

      return authUserModel == null ? AuthUser.empty : authUserModel.toEntity();
    });
  }

  @override
  Future<AuthUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );

    localDataSource.write(key: 'user', value: authModel);

    return authModel.toEntity();
  }

  @override
  Future<AuthUser?> signIn({
    required String email,
    required String password,
  }) async {
    AuthUser? authUser;

    try {
      final authModel = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('authModel: $authModel');

      localDataSource.write(key: 'user', value: authModel);
      authUser = authModel.toEntity();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
    return authUser;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();

    localDataSource.write(key: 'user', value: null);
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final authModel = await remoteDataSource.user.first;

    return authModel?.toEntity();
  }
}
