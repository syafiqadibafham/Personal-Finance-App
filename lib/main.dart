import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:personal_finance_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:personal_finance_app/features/home/presentation/home_screen.dart';
import 'package:personal_finance_app/features/profile/cubits/profile_cubit.dart';
import 'package:personal_finance_app/features/profile/data/profile_repository_impl.dart';
import 'package:personal_finance_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:personal_finance_app/themes/light_mode.dart';

import 'config/firebase_options.dart';
import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/entities/auth_user.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(await builder());
}

void main() {
  bootstrap(
    () async {
      AuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceFirebase();

      AuthRepository authRepository = AuthRepositoryImpl(
        localDataSource: authLocalDataSource,
        remoteDataSource: authRemoteDataSource,
      );

      ProfileRepository profileRepository = ProfileRepositoryImpl(
        localDataSource: authLocalDataSource,
      );

      return App(
        authUser: await authRepository.authUser.first,
        authRepository: authRepository,
        profileRepository: profileRepository,
      );
    },
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    required this.profileRepository,
    this.authUser,
  });

  final AuthRepository authRepository;
  final ProfileRepository profileRepository;
  final AuthUser? authUser;

  @override
  Widget build(BuildContext context) {
    // Provide cubits to app
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository: authRepository)..checkAuth(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepository: profileRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Clean Architecture',
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          // Listen for errors
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Login Error: ${state.message}'),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is AuthUnauthenticated || state is AuthError) {
              return const AuthScreen();
            }
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            }
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
