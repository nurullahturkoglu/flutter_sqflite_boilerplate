import 'package:sqflite/sqflite.dart';

import '../models/grocery.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    return await openDatabase(
      'my_database.db',
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE grocery (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      )
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('grocery', row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('grocery', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('grocery', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Grocery>> getContacts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('grocery');
    return result.isNotEmpty
        ? result.map((item) => Grocery.fromMap(item)).toList()
        : [];
  }
}
