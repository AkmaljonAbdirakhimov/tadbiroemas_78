import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiroemas_78/data/repositories/auth_repository.dart';
import 'package:tadbiroemas_78/data/repositories/todo_repository.dart';
import 'package:tadbiroemas_78/logic/blocs/auth/auth_bloc.dart';
import 'package:tadbiroemas_78/logic/blocs/my_bloc_observer.dart';
import 'package:tadbiroemas_78/logic/blocs/todo/todo_bloc.dart';
import 'package:tadbiroemas_78/services/firebase_auth_service.dart';
import 'package:tadbiroemas_78/services/firebase_todo_service.dart';

import 'core/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  final firebaseAuthService = FirebaseAuthService();
  final firebaseTodoService = FirebaseTodoService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (ctx) {
          return AuthRepository(firebaseAuthService: firebaseAuthService);
        }),
        RepositoryProvider(create: (ctx) {
          return TodoRepository(firebaseTodoService: firebaseTodoService);
        })
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) {
            return AuthBloc(authRepository: ctx.read<AuthRepository>());
          }),
          BlocProvider(create: (ctx) {
            return TodoBloc(todoRepository: ctx.read<TodoRepository>());
          }),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
