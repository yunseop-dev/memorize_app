import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditButton extends ConsumerWidget {
  late WidgetRef _ref;
  final Todo target;
  EditButton({super.key, required this.target});

  void _editTodoItem(String newTodo) async {
    _ref.read(todoListProvider.notifier).edit(id: target.id, text: newTodo);
  }

  void _showEditTodoDialog(BuildContext context) {
    TextEditingController controller = TextEditingController(text: target.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputString = '';
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            autofocus: true,
            controller: controller,
            onChanged: (v) {
              inputString = v;
            },
            onSubmitted: (newTodo) {
              _editTodoItem(newTodo);
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
                  if (inputString != '') {
                    _editTodoItem(inputString);
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Edit')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: 'edit',
      onPressed: () {
        _showEditTodoDialog(context);
      },
    );
  }
}
