import 'package:flutter/material.dart';
import 'package:flutter_todo/model/record_item.dart';
import 'package:flutter_todo/screen/record_item_detail.dart';
import 'package:flutter_todo/util/dateformat.dart';
import 'package:flutter_todo/widget/delete_record_item_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecordItemList extends HookConsumerWidget {
  final String memoryCardId;

  const RecordItemList({super.key, required this.memoryCardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(recordItemListProvider.call(memoryCardId));

    return switch (records) {
      AsyncError(:final error) => Text('Error: $error'),
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            RecordItem item = value[index];
            return ListTile(
              title: Text('녹음 ${index + 1}'),
              subtitle: Text(dateformat(item.createdAt)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RecordItemDetail(item: item, index: index + 1)));
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DeleteRecordItemButton(
                    target: item,
                  ),
                ],
              ),
            );
          },
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
