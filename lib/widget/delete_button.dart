import 'package:flutter/material.dart';
import 'package:malo_aamgi/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteButton extends ConsumerWidget {
  final Todo target;
  const DeleteButton({super.key, required this.target});

  void _deleteTodoItem(WidgetRef ref) async {
    ref.read(todoListProvider.notifier).remove(target);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: const Text('삭제', style: TextStyle(color: Colors.red)),
      onPressed: () {
        _deleteTodoItem(ref);
        Navigator.of(context).pop();
      },
    );
  }
}
