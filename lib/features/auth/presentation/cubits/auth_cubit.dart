/*

Auth Cubit: State Management

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/auth/domain/entities/auth_user.dart';
import 'package:personal_finance_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthUser? _currentUser;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  // check if user is already authenticated
  Future<void> checkAuth() async {
    try {
      emit(AuthLoading());
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // get current user
  AuthUser? get getCurrentUser => _currentUser;

  // sign in with email & pw
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepository.signIn(email: email, password: password);
      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // sign up with email & pw
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepository.signUp(email: email, password: password);
      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // logout
  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await authRepository.signOut();
      _currentUser = null;
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
