import 'package:tadbiroemas_78/data/models/todo.dart';
import 'package:tadbiroemas_78/services/firebase_todo_service.dart';

class TodoRepository {
  final FirebaseTodoService _firebaseTodoService;

  TodoRepository({required FirebaseTodoService firebaseTodoService})
      : _firebaseTodoService = firebaseTodoService;

  Stream<List<Todo>> getTodos() {
    return _firebaseTodoService.getTodos();
  }

  Future<void> addTodo(String title) async {
    await _firebaseTodoService.addTodo(title);
  }

  Future<void> editTodo(String id, String title) async {
    await _firebaseTodoService.editTodo(id, title);
  }

  Future<void> deleteTodo(String id) async {
    await _firebaseTodoService.deleteTodo(id);
  }

  Future<void> toggleTodo(String id, bool isDone) async {
    await _firebaseTodoService.toggleTodo(id, isDone);
  }
}
