/*

Auth States

*/

import 'package:personal_finance_app/features/auth/domain/entities/auth_user.dart';

abstract class AuthState {}

// Initial State
class AuthInitial extends AuthState {}

// Loading State
class AuthLoading extends AuthState {}

// Authenticated State
class AuthAuthenticated extends AuthState {
  final AuthUser user;
  AuthAuthenticated({required this.user});
}

// Unauthenticated State
class AuthUnauthenticated extends AuthState {}

// Error State
class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
