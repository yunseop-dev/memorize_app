import 'package:flutter_todo/db/db.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoRepository {
  static Future<void> add(Todo todo) async {
    final db = await TodoDatabase.instance.database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> edit(Todo target, Todo newTodo) async {
    final db = await TodoDatabase.instance.database;
    await db.update('todos', newTodo.toMap(),
        where: 'id = ?', whereArgs: [target.id]);
  }

  static Future<List<Todo>> getTodos() async {
    final db = await TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    });
  }

  static Future<void> delete(Todo target) async {
    final db = await TodoDatabase.instance.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [target.id]);
  }
}
