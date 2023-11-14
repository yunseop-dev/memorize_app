import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteButton extends ConsumerWidget {
  late WidgetRef _ref;
  final Todo target;
  DeleteButton({super.key, required this.target});

  void _deleteTodoItem() async {
    _ref.read(todoListProvider.notifier).remove(target);
  }

  void _showDeleteTodoDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Item"),
      content: const Text("Item will be deleted."),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Delete"),
          onPressed: () {
            _deleteTodoItem();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;
    return IconButton(
      icon: const Icon(Icons.delete),
      tooltip: 'delete',
      onPressed: () {
        _showDeleteTodoDialog(context);
      },
    );
  }
}
