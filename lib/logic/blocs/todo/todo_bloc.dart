import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

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
    on<AddTodoEvent>(
      _onAddTodo,
      transformer: _distinct(),
    );
    on<EditTodoEvent>(_onEditTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
  }

  void _onGetTodos(GetTodosEvent event, Emitter<TodoState> emit) async {
    emit(LoadingTodoState());

    try {
      await emit.forEach(
        _todoRepository.getTodos(),
        onData: (List<Todo> todos) {
          return LoadedTodoState(todos);
        },
      );
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onAddTodo(AddTodoEvent event, emit) async {
    emit(LoadingTodoState());
    try {
      await _todoRepository.addTodo(event.title);
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onEditTodo(EditTodoEvent event, emit) async {
    emit(LoadingTodoState());
    try {
      await _todoRepository.editTodo(event.id, event.title);
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onDeleteTodo(DeleteTodoEvent event, emit) async {
    emit(LoadingTodoState());
    try {
      await _todoRepository.deleteTodo(event.id);
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  void _onToggleTodo(ToggleTodoEvent event, emit) async {
    try {
      await _todoRepository.toggleTodo(event.id, event.isDone);
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  // birinchi (5) soniya kutib keyin ishlaydi (funksiyani chaqiradi)
  EventTransformer<AddTodoEvent> _debounce(Duration duration) {
    return (events, mapper) {
      return events.debounce(duration).switchMap(mapper);
    };
  }

// birinchi ishlaydi (funksiyani chaqiradi) keyin (5) soniya kutadi
  EventTransformer<AddTodoEvent> _throttle(Duration duration) {
    return (events, mapper) {
      return events.throttle(duration).switchMap(mapper);
    };
  }

  // agar har xil bo'lsa keyin ishlaydi (funksiyani chaqiradi)
  EventTransformer<AddTodoEvent> _distinct() {
    return (events, mapper) {
      return events.distinct((event1, event2) {
        return event1.title == event2.title;
      }).switchMap(mapper);
    };
  }
}
