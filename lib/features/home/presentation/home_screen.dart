import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/features/auth/presentation/components/pf_button.dart';
import 'package:personal_finance_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:personal_finance_app/features/home/presentation/components/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [],
        ),
        drawer: PfDrawer(),
        body: Column(children: [
          Text(authCubit.getCurrentUser!.toJson().toString()),
        ]));
  }
}
