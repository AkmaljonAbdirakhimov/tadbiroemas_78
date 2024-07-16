import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/todo.dart';

class FirebaseTodoService {
  final _todoCollection = FirebaseFirestore.instance.collection("todos");

  Stream<List<Todo>> getTodos() async* {
    yield* _todoCollection.snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => Todo(
                  id: doc.id,
                  title: doc['title'],
                  isDone: doc['isDone'],
                ))
            .toList();
      },
    );
  }

  Future<void> addTodo(String title) async {
    await _todoCollection.add({
      "title": title,
      "isDone": false,
    });
  }

  Future<void> editTodo(String id, String newTitle) async {
    await _todoCollection.doc(id).update({
      "title": newTitle,
    });
  }

  Future<void> deleteTodo(String id) async {
    await _todoCollection.doc(id).delete();
  }

  Future<void> toggleTodo(String id, bool isDone) async {
    await _todoCollection.doc(id).update({
      "isDone": isDone,
    });
  }
}
