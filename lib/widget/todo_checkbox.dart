import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoCheckbox extends ConsumerWidget {
  final Todo item;
  const TodoCheckbox({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Checkbox(
      value: item.done,
      onChanged: (bool? value) {
        ref.read(todoListProvider.notifier).toggle(item);
      },
    );
  }
}
