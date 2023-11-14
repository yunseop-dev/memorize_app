import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/repository/todo_repository.dart';

class DeleteButton extends StatelessWidget {
  final Todo target;
  const DeleteButton({super.key, required this.target});

  void _deleteTodoItem() async {
    await TodoRepository.delete(target);
    // await _loadTodos();
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
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      tooltip: 'delete',
      onPressed: () {
        _showDeleteTodoDialog(context);
      },
    );
  }
}
