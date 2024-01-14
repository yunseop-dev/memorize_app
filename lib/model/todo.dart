import 'package:flutter/foundation.dart';
import 'package:malo_aamgi/repository/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@immutable
class Todo {
  final String id;
  final String title;
  final String text;
  final bool done;

  Todo({
    String? id,
    required this.title,
    required this.text,
    this.done = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'done': done ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      text: map['text'],
      done: map['done'] == 1,
    );
  }
}

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() => TodoRepository.getTodos();

  Future<void> add(String title, String text) async {
    Todo newTodo = Todo(title: title, text: text);
    await TodoRepository.add(newTodo);
    state = state.whenData((value) => [...value, newTodo]);
  }

  void edit({required String id, required String title, required String text}) {
    TodoRepository.edit(Todo(id: id, title: title, text: text));
    state = state.whenData((value) => value
        .map((e) => e.id == id
            ? Todo(title: title, text: text, id: id, done: e.done)
            : e)
        .toList());
  }

  void remove(Todo target) {
    TodoRepository.delete(target);
    state = state.whenData(
        (value) => value.where((element) => element.id != target.id).toList());
  }

  void toggle(Todo item) {
    Todo todo =
        Todo(id: item.id, title: item.title, text: item.text, done: !item.done);
    TodoRepository.edit(todo);
    state = state.whenData(
        (value) => value.map((e) => e.id == item.id ? todo : e).toList());
  }
}

@riverpod
Future<Todo> memoryCardDetail(MemoryCardDetailRef ref, String id) async {
  return TodoRepository.getById(id);
}
