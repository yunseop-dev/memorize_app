import 'package:flutter/foundation.dart';
import 'package:flutter_todo/repository/record_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'record_item.g.dart';

@immutable
class RecordItem {
  final String id;
  final String text;
  final String memoryCardId;

  RecordItem({
    String? id,
    required this.text,
    required this.memoryCardId,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'memory_card_id': memoryCardId,
    };
  }

  factory RecordItem.fromMap(Map<String, dynamic> map) {
    return RecordItem(
      id: map['id'],
      text: map['text'],
      memoryCardId: map['memory_card_id'],
    );
  }
}

@riverpod
Future<List<RecordItem>> recordItemList(
    RecordItemListRef ref, String memoryCardId) async {
  return RecordItemRepository.getItems(memoryCardId);
}
