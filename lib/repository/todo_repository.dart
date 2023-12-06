import 'package:flutter_todo/db/db.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoRepository {
  static Future<void> add(Todo todo) async {
    final db = await TodoDatabase.instance.database;
    await db.insert(
      'memory_cards',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> edit(String id, Todo newTodo) async {
    final db = await TodoDatabase.instance.database;
    await db.update('memory_cards', newTodo.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Todo>> getTodos() async {
    final db = await TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('memory_cards');
    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    });
  }

  static Future<Todo> getById(String id) async {
    final db = await TodoDatabase.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'memory_cards',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromMap(maps[0]);
    } else {
      throw Exception('Todo not found');
    }
  }

  static Future<void> delete(Todo target) async {
    final db = await TodoDatabase.instance.database;
    await db.delete('memory_cards', where: 'id = ?', whereArgs: [target.id]);
  }
}
