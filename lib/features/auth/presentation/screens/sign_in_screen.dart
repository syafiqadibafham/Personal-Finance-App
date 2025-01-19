import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_button.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_text_field.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_states.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_in_use_case.dart';
import '../blocs/email_status.dart';
import '../blocs/form_status.dart';
import '../blocs/password_status.dart';
import '../blocs/sign_in/sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SignInView(
      onTap: onTap,
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  Timer? debounce;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    debounce?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final authCubit = context.read<AuthCubit>();
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await authCubit.signInWithEmailAndPassword(email, password);
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
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Invalid form: please fill in all fields'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Finance',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 15,
            children: [
              Text('Welcome back to your personal finance app!'),
              PfTextField(
                key: const Key('signIn_emailInput_textField'),
                labelText: 'Email',
                controller: _emailController,
                //errorText: state.emailStatus == EmailStatus.invalid ? 'Invalid email' : null,
                // onChanged: (String value) {
                //   if (debounce?.isActive ?? false) debounce?.cancel();
                //   debounce = Timer(const Duration(milliseconds: 500), () {
                //     context.read<SignInCubit>().emailChanged(value);
                //   });
                // },
              ),
              PfTextField(
                key: const Key('signIn_passwordInput_textField'),
                isObscureText: true,
                labelText: 'Password',
                controller: _passwordController,
                //errorText: state.passwordStatus == PasswordStatus.invalid ? 'Invalid password' : null,
                // onChanged: (String value) {
                //   context.read<SignInCubit>().passwordChanged(value);
                // },
              ),
              const SizedBox(height: 8.0),
              PfButton(
                key: const Key('signIn_continue_elevatedButton'),
                labelText: 'Sign In',
                onTap:
                    // context.read<SignInCubit>().state.formStatus == FormStatus.submissionInProgress
                    //     ? null
                    //     :
                    () {
                  _login();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Sign up here!",
                        style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
