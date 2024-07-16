import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/auth/auth_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
                accountName: Text(state is LoggedInState
                    ? state.user.displayName ?? "Ism va Familiya"
                    : "Unknown User"),
                accountEmail: Text(state is LoggedInState
                    ? state.user.email ?? "Email"
                    : "Unknown Email"),
              );
            },
          ),
          const Spacer(),
          ListTile(
            contentPadding: const EdgeInsets.all(20),
            leading: const Icon(Icons.logout),
            title: const Text("Chiqish"),
            onTap: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
    );
  }
}
