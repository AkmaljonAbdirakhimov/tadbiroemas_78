import 'package:bloc/bloc.dart';

import '../../../data/models/todo.dart';
import '../../../data/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc({
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(InitialTodoState()) {
    on<GetTodosEvent>(_onGetTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<EditTodoEvent>(_onEditTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
  }

  void _onGetTodos(GetTodosEvent event, emit) async {
    emit(LoadingTodoState());

    try {
      final todos = await _todoRepository.getTodos().first;
      emit(LoadedTodoState(todos));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onAddTodo(AddTodoEvent event, emit) async {
    emit(LoadingTodoState());
    try {
      await _todoRepository.addTodo(event.title);
      final todos = await _todoRepository.getTodos().first;
      emit(LoadedTodoState(todos));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onEditTodo(EditTodoEvent event, emit) async {
    emit(LoadingTodoState());
    try {
      await _todoRepository.editTodo(event.id, event.title);
      final todos = await _todoRepository.getTodos().first;
      emit(LoadedTodoState(todos));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onDeleteTodo(DeleteTodoEvent event, emit) async {
    emit(LoadingTodoState());
    try {
      await _todoRepository.deleteTodo(event.id);
      final todos = await _todoRepository.getTodos().first;
      emit(LoadedTodoState(todos));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onToggleTodo(ToggleTodoEvent event, emit) async {
    try {
      await _todoRepository.toggleTodo(event.id, event.isDone);
      final todos = await _todoRepository.getTodos().first;
      emit(LoadedTodoState(todos));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }
}
