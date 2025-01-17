// Mocks generated by Mockito 5.4.0 from annotations
// in personal_finance_app/test/src/features/auth/presentation/blocs/sign_in/sign_in_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:personal_finance_app/features/auth/domain/entities/auth_user.dart' as _i3;
import 'package:personal_finance_app/features/auth/domain/repositories/auth_repository.dart' as _i2;
import 'package:personal_finance_app/features/auth/domain/use_cases/sign_in_use_case.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAuthRepository_0 extends _i1.SmartFake implements _i2.AuthRepository {
  _FakeAuthRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAuthUser_1 extends _i1.SmartFake implements _i3.AuthUser {
  _FakeAuthUser_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SignInUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSignInUseCase extends _i1.Mock implements _i4.SignInUseCase {
  MockSignInUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AuthRepository get authRepository => (super.noSuchMethod(
        Invocation.getter(#authRepository),
        returnValue: _FakeAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
      ) as _i2.AuthRepository);
  @override
  _i5.Future<_i3.AuthUser> call(_i4.SignInParams? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.AuthUser>.value(_FakeAuthUser_1(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.AuthUser>);
}
