import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditButton extends ConsumerWidget {
  final Todo target;
  const EditButton({super.key, required this.target});

  void _editTodoItem(String title, String text, WidgetRef ref) async {
    ref
        .read(todoListProvider.notifier)
        .edit(id: target.id, title: title, text: text);
  }

  void _showEditTodoDialog(BuildContext context, WidgetRef ref) {
    TextEditingController titleController =
        TextEditingController(text: target.title);
    TextEditingController textController =
        TextEditingController(text: target.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = target.title;
        String text = target.text;
        return AlertDialog(
          title: const Text('내용 수정'),
          content: Column(
            children: [
              TextField(
                autofocus: true,
                controller: titleController,
                onChanged: (v) {
                  title = v;
                },
              ),
              TextField(
                autofocus: true,
                controller: textController,
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
                child: const Text('취소')),
            TextButton(
                onPressed: () {
                  _editTodoItem(title, text, ref);
                  Navigator.of(context).pop();
                },
                child: const Text('수정')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: '내용 수정',
      onPressed: () {
        _showEditTodoDialog(context, ref);
      },
    );
  }
}
