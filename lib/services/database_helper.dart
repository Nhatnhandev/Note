import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes_v2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, filePath),
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT, content TEXT, createdAt TEXT,
          isPinned INTEGER, colorValue INTEGER, tag TEXT
        )
      ''');
      },
    );
  }

  Future<List<Note>> getAllNotes() async {
    final db = await instance.database;
    final result = await db.query(
      'notes',
      orderBy: 'isPinned DESC, createdAt DESC',
    );
    return result.map((json) => Note.fromMap(json)).toList();
  }

  Future<int> insert(Note note) async =>
      (await database).insert('notes', note.toMap());
  Future<int> update(Note note) async => (await database).update(
    'notes',
    note.toMap(),
    where: 'id = ?',
    whereArgs: [note.id],
  );
  Future<int> delete(int id) async =>
      (await database).delete('notes', where: 'id = ?', whereArgs: [id]);
}
