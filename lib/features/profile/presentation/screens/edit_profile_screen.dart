import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_button.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_text_field.dart';
import 'package:personal_finance_app/features/home/presentation/components/loading_indicator.dart';
import 'package:personal_finance_app/features/profile/cubits/profile_cubit.dart';
import 'package:personal_finance_app/features/profile/cubits/profile_state.dart';
import 'package:personal_finance_app/features/profile/domain/entities/profile_user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});

  final ProfileUser user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameTextController = TextEditingController();

  _updateProfile() {
    final profileCubit = context.read<ProfileCubit>();
    profileCubit.updateProfile(id: widget.user.id, name: nameTextController.text);
  }

  @override
  void initState() {
    super.initState();

    nameTextController.text = widget.user.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        Widget? child;
        if (state is ProfileLoading) {
          child = const LoadingIndicator();
        }

        if (state is ProfileLoaded) {
          child = Column(
            children: [
              PfTextField(
                controller: nameTextController,
                labelText: 'Name',
              ),
              PfButton(
                onTap: _updateProfile,
                labelText: 'Save',
              ),
            ],
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: Center(child: child),
        );
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }
}
