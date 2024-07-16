import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiroemas_78/logic/blocs/auth/auth_bloc.dart';
import 'package:tadbiroemas_78/ui/screens/home_screen.dart';
import 'package:tadbiroemas_78/ui/screens/login_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        bloc: context.read<AuthBloc>()..add(CheckUserStateEvent()),
        builder: (ctx, state) {
          if (state is LoggedInState) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
