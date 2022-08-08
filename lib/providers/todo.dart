import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

final todoListProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());

enum TodoListFilter {
  all,
  active,
  completed,
}

/// 現在デフォルトで有効なフィルター
final todoListFilter = StateProvider((_) => TodoListFilter.all);

/// 未完了なTodoの数
final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.done).length;
});

/// これを呼ぶとフィルターを通したTodoリストを取得できる
/// example
/// ```dart
/// final todoList = ref.watch(filterdTodos);
/// ```
final filterdTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.done).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.done).toList();
    case TodoListFilter.all:
    default:
      return todos.toList();
  }
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super(<Todo>[]);

  void add(Todo todo) {
    state = [...state, todo];
  }

  void remove(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId) todo.copyWith(done: !todo.done) else todo,
    ];
  }
}

@immutable
class Todo {
  const Todo({required this.id, required this.description, required this.done});

  final String description;
  final bool done;
  final String id;

  Todo copyWith({String? id, String? description, bool? done}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }
}
