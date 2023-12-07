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
  final DateTime createdAt;

  RecordItem({
    String? id,
    required this.text,
    required this.memoryCardId,
    DateTime? createdAt, // createdAt를 선택적(optional)으로 변경
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'memory_card_id': memoryCardId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory RecordItem.fromMap(Map<String, dynamic> map) {
    return RecordItem(
      id: map['id'],
      text: map['text'],
      memoryCardId: map['memory_card_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

@riverpod
class RecordItemList extends _$RecordItemList {
  @override
  Future<List<RecordItem>> build(String memoryCardId) =>
      RecordItemRepository.getItems(memoryCardId);

  Future<void> add(RecordItem item) async {
    RecordItemRepository.add(item);
    state = state.whenData((value) => [...value, item]);
  }
}
