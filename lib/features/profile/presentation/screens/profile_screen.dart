import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/auth/domain/entities/auth_user.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_button.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:personal_finance_app/features/home/presentation/components/loading_indicator.dart';
import 'package:personal_finance_app/features/profile/cubits/profile_cubit.dart';
import 'package:personal_finance_app/features/profile/cubits/profile_state.dart';
import 'package:personal_finance_app/features/profile/presentation/screens/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String id;
  const ProfileScreen({super.key, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  late AuthUser? currentUser = authCubit.getCurrentUser;

  @override
  void initState() {
    super.initState();

    profileCubit.getProfile(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        Widget? child;
        List<Widget>? actions;
        if (state is ProfileLoaded) {
          final profilePicture = state.profileUser.profileImageUrl;
          actions = [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfileScreen(user: state.profileUser),
                ));
              },
              icon: const Icon(Icons.edit),
            ),
          ];
          child = Column(
            spacing: 20,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  image: profilePicture != null
                      ? DecorationImage(
                          image: NetworkImage(profilePicture),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Icon(Icons.person),
              ),
              Text(state.profileUser.profileImageUrl ?? 'No Profile Image'),
              Text(state.profileUser.email),
              Text(state.profileUser.name ?? 'Empty'),
            ],
          );
        }
        if (state is ProfileLoading) {
          child = const LoadingIndicator();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: actions,
          ),
          body: Center(
            child: child,
          ),
        );
      },
    );
  }
}
