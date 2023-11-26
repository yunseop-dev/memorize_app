import 'package:flutter_todo/db/db.dart';
import 'package:flutter_todo/model/record_item.dart';
import 'package:sqflite/sqflite.dart';

class RecordItemRepository {
  static Future<void> add(RecordItem item) async {
    final db = await TodoDatabase.instance.database;
    await db.insert(
      'records',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> edit(String id, RecordItem newItem) async {
    final db = await TodoDatabase.instance.database;
    await db
        .update('records', newItem.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<RecordItem>> getItems(String memoryCardId) async {
    final db = await TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('records',
        where: 'memory_card_id = ?', whereArgs: [memoryCardId]);
    return List.generate(maps.length, (index) {
      return RecordItem.fromMap(maps[index]);
    });
  }

  static Future<void> delete(RecordItem target) async {
    final db = await TodoDatabase.instance.database;
    await db.delete('records', where: 'id = ?', whereArgs: [target.id]);
  }
}
