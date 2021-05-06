import 'dart:convert';
import 'package:flutter/services.dart';
import 'roles.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String TABLE_Roles = 'roles';
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_DESCRIPTION = 'description';
  static const String COLUMN_ISFIRSTROLE = 'isFirstRole';
  static const String COLUMN_ISSECONDROLE = 'isSecondRole';
  static const String COLUMN_ISSELECTED = 'isselected';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'UnsereDb.db'),
      version: 1,
      onOpen: (Database db) {
        print("open Database");
      },
      onCreate: (Database db, int version) async {
        print("creating Roles Table");
        await db.execute(
          "CREATE TABLE $TABLE_Roles ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_NAME TEXT,"
          "$COLUMN_DESCRIPTION TEXT,"
          "$COLUMN_ISFIRSTROLE INTEGER,"
          "$COLUMN_ISSECONDROLE INTEGER,"
          "$COLUMN_ISSELECTED INTEGER"
          ")",
        );
        try {
          String contents = await rootBundle.loadString('assets/roles.json');
          List<dynamic> json = jsonDecode(contents);

          for (var rolesMap in json) {
            db.insert("roles", Roles.fromMap(rolesMap).toMap());
          }
        } catch (err) {
          print(err);
        }
      },
    );
  }

  Future<void> createRoles(Roles newRoles) async {
    final Database db = await database;
    try {
      await db.insert("Roles", newRoles.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      print(err);
    }
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    final Database db = await database;
    return await db.query('Roles');
  }

  Future<List<Roles>> readAllRoles() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps;
    try {
      maps = await db.query('Roles');
    } catch (err) {
      print(err);
    }
    return List.generate(maps.length, (i) {
      return Roles.fromMap(maps[i]);
    });
  }

  Future<List<Roles>> readSelectedRoles() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps;

    try {
      maps = await db.query("Roles", where: "isSelected = ?", whereArgs: [1]);
    } catch (err) {
      print(err);
    }

    return List.generate(maps.length, (i) {
      return Roles.fromMap(maps[i]);
    });
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_Roles,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Roles _role) async {
    final db = await database;

    return await db.update(
      TABLE_Roles,
      _role.toMap(),
      where: "id = ?",
      whereArgs: [_role.properties.id],
    );
  }
}