import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_button.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_text_field.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SignUpView(onTap: onTap);
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  Timer? debounce;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  String? _repeatPasswordErrorText;

  @override
  void dispose() {
    debounce?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields'),
          ),
        );
      return;
    }

    if (password != repeatPassword) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
      return;
    }

    try {
      await authCubit.signUpWithEmailAndPassword(name, email, password);
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Login successful: ${authCubit.getCurrentUser}'),
            ),
          );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Login Error: $e'),
            ),
          );
      }
    }
  }

  void _validateRepeatPassword() {
    setState(() {
      if (_repeatPasswordController.text != _passwordController.text) {
        _repeatPasswordErrorText = 'Passwords do not match';
      } else {
        _repeatPasswordErrorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sign Up',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 10,
            children: [
              PfTextField(
                key: const Key('signUp_nameInput_textField'),
                controller: _nameController,
                labelText: 'Name',
                // errorText: state.emailStatus == EmailStatus.invalid ? 'Invalid email' : null,
                // onChanged: (String value) {
                //   if (debounce?.isActive ?? false) debounce?.cancel();
                //   debounce = Timer(const Duration(milliseconds: 500), () {
                //     context.read<SignUpCubit>().emailChanged(value);
                //   });
                // },
              ),
              PfTextField(
                key: const Key('signUp_emailInput_textField'),
                controller: _emailController,
                labelText: 'Email',
                // errorText: state.emailStatus == EmailStatus.invalid ? 'Invalid email' : null,
                // onChanged: (String value) {
                //   if (debounce?.isActive ?? false) debounce?.cancel();
                //   debounce = Timer(const Duration(milliseconds: 500), () {
                //     context.read<SignUpCubit>().emailChanged(value);
                //   });
                // },
              ),
              PfTextField(
                key: const Key('signUp_passwordInput_textField'),
                isObscureText: true,
                controller: _passwordController,
                labelText: 'Password',
                // errorText: state.passwordStatus == PasswordStatus.invalid ? 'Invalid password' : null,
                // onChanged: (String value) {
                //   context.read<SignUpCubit>().passwordChanged(value);
                // },
              ),
              PfTextField(
                key: const Key('signUp_repearPasswordInput_textField'),
                isObscureText: true,
                controller: _repeatPasswordController,
                labelText: 'Confirm Password',
                errorText: _repeatPasswordErrorText,
                onChanged: (String value) {
                  //context.read<SignUpCubit>().passwordChanged(value);
                  _validateRepeatPassword();
                },
              ),
              const SizedBox(height: 8.0),
              PfButton(
                key: const Key('signUp_continue_elevatedButton'),
                onTap:
                    // context.read<SignUpCubit>().state.formStatus == FormStatus.submissionInProgress
                    //     ? null
                    //     :
                    () {
                  _signUp();
                },
                labelText: 'Sign Up',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Sign in here!",
                        style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
