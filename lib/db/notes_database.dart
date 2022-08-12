import 'dart:async';

import 'package:google_keep_clone/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class NotesDatabase {
  static final instance = NotesDatabase._();
  NotesDatabase._();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDB('notes.db');
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        createdTime TEXT,
        color TEXT
      )
      ''');
  }

  Future<void> createNote(NoteModel note) async {
    final db = await instance.database;
    await db.insert('notes', note.toMap());
  }

  Future<NoteModel> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query('notes',
        columns: ['_id', 'title', 'content', 'createdTime', 'color'],
        where: '_id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return NoteModel.fromMap(maps[0]);
    } else {
      throw Exception('$id not found.');
    }
  }

  Future<List<NoteModel>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = 'createdTime ASC';
    final result = await db.query('notes', orderBy: orderBy);
    return result.map((map) => NoteModel.fromMap(map)).toList();
  }

  Future<int> updateNote(NoteModel note) async {
    final db = await instance.database;

    return await db.update(
      'notes',
      note.toMap(),
      where: '_id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'notes',
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
