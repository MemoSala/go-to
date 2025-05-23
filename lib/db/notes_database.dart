// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

enum TimeASC { time, timeEnd, timeWait }

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  // Get Data
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("notes.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute("""
      CREATE TABLE $tableNotes (
        ${NoteFields.id} $idType,
        ${NoteFields.isImportant} $boolType,
        ${NoteFields.number} $integerType,
        ${NoteFields.chapterEnd} $integerType,
        ${NoteFields.chapterWait} $integerType,
        ${NoteFields.title} $textType,
        ${NoteFields.urlWeb} $textType,
        ${NoteFields.description} $textType,
        ${NoteFields.codeImg} $textType,
        ${NoteFields.codeItems} $textType,
        ${NoteFields.time} $textType,
        ${NoteFields.timeEnd} $textType,
        ${NoteFields.timeWait} $textType)
      """);
  }

  // Create Data
  Future cerate(Note note) async {
    final db = await instance.database;
    await db.insert(tableNotes, note.toJson());
  }

  // Read Data
  Future<Note> readNote(int id) async {
    Database db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,

      /// '${NoteFields.id} = $id' غير امن
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNote({TimeASC timeASC = TimeASC.time}) async {
    final db = await instance.database;

    final String noteFieldsASC;
    switch (timeASC) {
      case TimeASC.time:
        noteFieldsASC = NoteFields.time;
        break;
      case TimeASC.timeEnd:
        noteFieldsASC = NoteFields.timeEnd;
        break;
      case TimeASC.timeWait:
        noteFieldsASC = NoteFields.timeWait;
        break;
    }
    final orderBy = '$noteFieldsASC ASC';

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  // Update Data
  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  // Delete Data
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;

    return await db.delete(tableNotes);
  }

  // Close Data
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
