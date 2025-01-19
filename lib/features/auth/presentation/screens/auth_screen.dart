import 'package:flutter/material.dart';
import 'package:personal_finance_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:personal_finance_app/features/auth/presentation/screens/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showhowSignInScreen = true;

  void toggleScreen() {
    setState(() {
      showhowSignInScreen = !showhowSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showhowSignInScreen ? SignInScreen(onTap: () => toggleScreen()) : SignUpScreen(onTap: () => toggleScreen());
  }
}
