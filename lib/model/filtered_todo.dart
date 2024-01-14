import 'package:malo_aamgi/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_todo.g.dart';

enum TodoListFilter {
  active,
  done,
  all,
}

final todoListFilter = StateProvider((_) => TodoListFilter.active);

@riverpod
AsyncValue<List<Todo>> filteredTodo(FilteredTodoRef ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);
  switch (filter) {
    case TodoListFilter.done:
      return todos
          .whenData((value) => value.where((todo) => todo.done).toList());
    case TodoListFilter.active:
      return todos
          .whenData((value) => value.where((todo) => !todo.done).toList());
    case TodoListFilter.all:
      return todos;
  }
}
