import 'package:flutter/material.dart';
import 'package:malo_aamgi/model/todo.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: '제목',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                  ),
                  onChanged: (v) {
                    title = v;
                  },
                ),
              ),
              TextField(
                maxLines: null,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: '내용',
                  hintText: '내용을 입력하세요...',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                ),
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
                child: const Text(
                  '취소',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  _addTodoItem(title, text, ref);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  '입력',
                  style: TextStyle(color: Colors.black),
                )),
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
    return Container(
      width: 48,
      height: 48,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: IconButton.outlined(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _showAddTodoDialog(context, ref);
                  }))
        ],
      ),
    );
  }
}
