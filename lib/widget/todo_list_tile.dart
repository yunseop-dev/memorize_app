import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/screen/todo_item_detail.dart';
import 'package:flutter_todo/widget/delete_button.dart';
import 'package:flutter_todo/widget/edit_button.dart';
import 'package:flutter_todo/widget/todo_checkbox.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoListTile extends ConsumerWidget {
  final Todo item;
  const TodoListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(item.text),
      leading: TodoCheckbox(item: item),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TodoItemDetail(item: item)));
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          EditButton(
            target: item,
          ),
          DeleteButton(
            target: item,
          ),
        ],
      ),
    );
  }
}
