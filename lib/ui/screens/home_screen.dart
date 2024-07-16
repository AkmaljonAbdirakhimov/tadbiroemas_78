import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiroemas_78/logic/blocs/todo/todo_bloc.dart';
import 'package:tadbiroemas_78/ui/widgets/add_todo_dialog.dart';
import 'package:tadbiroemas_78/ui/widgets/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return const AddTodoDialog();
                  });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: BlocBuilder<TodoBloc, TodoState>(
        bloc: context.read<TodoBloc>()..add(GetTodosEvent()),
        builder: (context, state) {
          if (state is LoadingTodoState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorTodoState) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is LoadedTodoState) {
            return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (ctx, index) {
                  final todo = state.todos[index];
                  return ListTile(
                    leading: IconButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                              ToggleTodoEvent(
                                id: todo.id,
                                isDone: !todo.isDone,
                              ),
                            );
                      },
                      icon: Icon(todo.isDone
                          ? Icons.check_circle
                          : Icons.circle_outlined),
                    ),
                    title: Text(todo.title),
                  );
                });
          }

          return const Center(
            child: Text("Rejalar mavjud emas"),
          );
        },
      ),
    );
  }
}
