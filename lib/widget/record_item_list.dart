import 'package:flutter/material.dart';
import 'package:flutter_todo/model/record_item.dart';
import 'package:flutter_todo/screen/record_item_detail.dart';
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
              title: Text('녹음 $index'),
              subtitle: const Text('yyyy-mm-dd'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecordItemDetail(item: item)));
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_arrow_rounded),
                    onPressed: () {
                      print('play');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop_rounded),
                    onPressed: () {
                      print('stop');
                    },
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
