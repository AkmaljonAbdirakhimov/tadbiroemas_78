part of 'todo_bloc.dart';

sealed class TodoState {}

final class InitialTodoState extends TodoState {}

final class LoadingTodoState extends TodoState {}

final class LoadedTodoState extends TodoState {
  final List<Todo> todos;
  LoadedTodoState(this.todos);

  // bool operator ==(Object other) {
  //   if (identical(other, this) ||
  //       (other is LoadedTodoState && other.todos == todos)) {
  //     return true;
  //   }
  //   {
  //     return false;
  //   }
  // }

  // @override
  // int get hashCode {
  //   return Object.hash(todos, this);
  // }
}

final class ErrorTodoState extends TodoState {
  final String error;

  ErrorTodoState(this.error);
}
