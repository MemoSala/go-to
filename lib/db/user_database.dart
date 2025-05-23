// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class UsersDatabase {
  static final UsersDatabase instance = UsersDatabase._init();

  static Database? _database;

  UsersDatabase._init();

  // Get Data
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("Users.db");
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

    await db.execute("""
      CREATE TABLE $tableUsers (
        ${UserFields.id} $idType,
        ${UserFields.name} $textType,
        ${UserFields.idUser} $textType,
        ${UserFields.email} $textType,
        ${UserFields.profileImage} $textType,
        ${UserFields.backgroundImage} $textType)
      """);
  }

  // Create Data
  Future<User> cerate(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(id: id);
  }

  // Read Data
  Future<User> readUser(int id) async {
    Database db = await instance.database;
    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,

      /// '${UserFields.id} = $id' غير امن
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUser() async {
    final db = await instance.database;

    final result = await db.query(tableUsers);

    return result.map((json) => User.fromJson(json)).toList();
  }

  // Update Data
  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      tableUsers,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  // Delete Data
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Close Data
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
