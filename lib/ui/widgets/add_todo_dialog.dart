import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/todo/todo_bloc.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is LoadedTodoState) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: const Text("Reja"),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Reja",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Bekor Qilish"),
          ),
          FilledButton(
            onPressed: () {
              context.read<TodoBloc>().add(
                    AddTodoEvent(title: titleController.text),
                  );
            },
            child: const Text("Qo'shish"),
          ),
        ],
      ),
    );
  }
}
