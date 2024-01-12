import 'package:flutter/foundation.dart';
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

  void doNothing(BuildContext ctx) {
    print('aa');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              style: BorderStyle.solid,
              color: Colors.black.withOpacity(0.1)),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Dismissible(
        key: Key(item.id),
        background: Container(),
        secondaryBackground: Container(
          decoration: const ShapeDecoration(
            color: Color(0x19F14343),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete,
              size: 36, color: Color.fromRGBO(241, 67, 67, 1)),
        ),
        confirmDismiss: (direction) {
          if (direction == DismissDirection.endToStart) {
            return showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text('삭제 하시겠습니까?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          return Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          '취소',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      DeleteButton(
                        target: item,
                      ),
                    ],
                  );
                });
          }
          return Future.value(false);
        },
        child: ListTile(
          title: Text(item.title),
          subtitle: Text(
            item.text,
            overflow: TextOverflow.ellipsis,
          ),
          leading: TodoCheckbox(item: item),
          horizontalTitleGap: 16,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TodoItemDetail(item: item)));
          },
        ),
      ),
    );
  }
}
