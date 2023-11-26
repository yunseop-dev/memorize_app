import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddButton extends ConsumerWidget {
  const AddButton({super.key});

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String text = '';
        return AlertDialog(
          title: const Text('문장 추가'),
          content: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: '제목을 입력하세요...'),
                onChanged: (v) {
                  title = v;
                },
              ),
              TextField(
                maxLines: null,
                autofocus: true,
                decoration: const InputDecoration(hintText: '내용을 입력하세요...'),
                onChanged: (v) {
                  text = v;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  _addTodoItem(title, text, ref);
                  Navigator.of(context).pop();
                },
                child: const Text('Input')),
          ],
        );
      },
    );
  }

  void _addTodoItem(String title, String text, WidgetRef ref) async {
    ref.read(todoListProvider.notifier).add(title, text);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        _showAddTodoDialog(context, ref);
      },
      tooltip: '문장 추가',
      child: const Icon(Icons.add),
    );
  }
}
