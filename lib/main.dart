import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/widget/add_button.dart';
import 'package:flutter_todo/widget/todo_list_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> result = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: switch (result) {
        AsyncError(:final error) => Text('Error: $error'),
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              Todo item = value[index];
              return TodoListTile(item: item);
            }),
        _ => const Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: const AddButton(),
    );
  }
}
