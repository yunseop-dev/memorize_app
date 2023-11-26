import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('memorize.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE memory_cards (
        id TEXT PRIMARY KEY,
        title TEXT,
        text TEXT,
        done INTEGER,
        created_at DATETIME,
        updated_at DATETIME
      );

      CREATE TABLE records (
        id INTEGER PRIMARY KEY,
        text TEXT,
        created_at DATETIME,
        updated_at DATETIME,
        path TEXT,
        memory_card_id INTEGER,
        FOREIGN KEY (memory_card_id) REFERENCES memory_cards (id)
      );
    ''');
  }
}
