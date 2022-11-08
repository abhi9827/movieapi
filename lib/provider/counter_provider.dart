import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = ChangeNotifierProvider((ref) => CounterProvider());

final countStateProvider = StateProvider<int>((ref) => 0);

class CounterProvider extends ChangeNotifier {
  int number = 0;

  void increment() {
    number++;
    notifyListeners();
  }

  void decrement() {
    number--;
    notifyListeners();
  }
}

class Todo {
  String todo;
  String dateTime;
  Todo({required this.todo, required this.dateTime});
}

// class A{
//   final String a;
//   A({required this.a});
// }
//
//
// class B extends A{
//   B({required super.a});
// }

final todoProvider =
    StateNotifierProvider<TodoProvider, List<Todo>>((ref) => TodoProvider([]));

class TodoProvider extends StateNotifier<List<Todo>> {
  TodoProvider(super.state);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(int index) {
    state.removeAt(index);
    state = [...state];
  }

  void updateTodo(Todo todo, String updateTodo) {
    todo.todo = updateTodo;
    state = [...state];
  }
}
