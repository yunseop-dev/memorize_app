import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddButton extends ConsumerWidget {
  const AddButton({super.key});

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputString = '';
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            autofocus: true,
            onChanged: (v) {
              inputString = v;
            },
            onSubmitted: (newTodo) {
              _addTodoItem(newTodo, ref);
              inputString = '';
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  _addTodoItem(inputString, ref);
                  Navigator.of(context).pop();
                },
                child: const Text('Input')),
          ],
        );
      },
    );
  }

  void _addTodoItem(String newTodo, WidgetRef ref) async {
    ref.read(todoListProvider.notifier).add(newTodo);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        _showAddTodoDialog(context, ref);
      },
      tooltip: 'Add Todo',
      child: const Icon(Icons.add),
    );
  }
}
