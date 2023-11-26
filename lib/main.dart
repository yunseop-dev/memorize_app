import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_todo/model/filtered_todo.dart';
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
      title: 'Memorize App',
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
    final todo = ref.watch(filteredTodoProvider);
    final currentIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('문장 암기 앱'),
      ),
      body: switch (todo) {
        AsyncError(:final error) => Text('Error: $error'),
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              Todo item = value[index];
              return TodoListTile(item: item);
            }),
        _ => const Center(child: CircularProgressIndicator()),
      },
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: '전체보기'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: '암기 중'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: '완료'),
        ],
        currentIndex: currentIndex.value,
        onTap: (value) {
          currentIndex.value = value;
          TodoListFilter type = TodoListFilter.values[value];
          ref.read(todoListFilter.notifier).state = type;
        },
      ),
      floatingActionButton: const AddButton(),
    );
  }
}
