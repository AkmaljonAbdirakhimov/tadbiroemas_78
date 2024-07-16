part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class GetTodosEvent extends TodoEvent {}

final class EditTodoEvent extends TodoEvent {
  final String title;
  final String id;

  EditTodoEvent({
    required this.title,
    required this.id,
  });
}

final class AddTodoEvent extends TodoEvent {
  final String title;

  AddTodoEvent({
    required this.title,
  });
}

final class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent({
    required this.id,
  });
}

final class ToggleTodoEvent extends TodoEvent {
  final String id;
  final bool isDone;

  ToggleTodoEvent({
    required this.id,
    required this.isDone,
  });
}
