import 'package:flutter/material.dart';
import 'package:malo_aamgi/model/record_item.dart';
import 'package:malo_aamgi/screen/record_item_detail.dart';
import 'package:malo_aamgi/util/dateformat.dart';
import 'package:malo_aamgi/widget/delete_record_item_button.dart';
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
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: Colors.black.withOpacity(0.1)),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: ListTile(
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
              ),
            );
          },
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
