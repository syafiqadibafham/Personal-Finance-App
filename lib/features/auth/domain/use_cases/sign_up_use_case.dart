import 'package:personal_finance_app/features/auth/domain/value_objects/name.dart';

import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<AuthUser?> call(SignUpParams params) async {
    try {
      AuthUser? authUser = await authRepository.signUp(
        name: params.name.value,
        email: params.email.value,
        password: params.password.value,
      );
      return authUser;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class SignUpParams {
  final Name name;
  final Email email;
  final Password password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
