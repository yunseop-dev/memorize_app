import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/repository/todo_repository.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  void _showAddTodoDialog(BuildContext context) {
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
              _addTodoItem(newTodo);
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
                  _addTodoItem(inputString);
                  Navigator.of(context).pop();
                },
                child: const Text('Input')),
          ],
        );
      },
    );
  }

  void _addTodoItem(String newTodo) async {
    Todo todo = Todo(text: newTodo, done: false);
    await TodoRepository.add(todo);
    // await _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddTodoDialog(context);
      },
      tooltip: 'Add Todo',
      child: const Icon(Icons.add),
    );
  }
}
