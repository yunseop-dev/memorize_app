import 'package:flutter/material.dart';
import 'package:malo_aamgi/model/record_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteRecordItemButton extends ConsumerWidget {
  final RecordItem target;
  const DeleteRecordItemButton({super.key, required this.target});

  void _deleteItem(WidgetRef ref) async {
    ref
        .read(RecordItemListProvider(target.memoryCardId).notifier)
        .remove(target);
  }

  void _showDeleteItemDialog(BuildContext context, WidgetRef ref) {
    AlertDialog alert = AlertDialog(
      title: const Text("녹음 삭제"),
      content: const Text("녹음한 내용이 삭제됩니다."),
      actions: [
        TextButton(
          child: const Text(
            "취소",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            "삭제",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            _deleteItem(ref);
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
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.black,
      ),
      tooltip: '삭제',
      onPressed: () {
        _showDeleteItemDialog(context, ref);
      },
    );
  }
}
