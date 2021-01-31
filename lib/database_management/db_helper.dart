//Class that manage the database, initialization, create tables ecc...

import 'dart:async';
import 'dart:io';

import 'package:graduation_grade/global_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;
class DbHelper {

  //Create the table of exams
  Future<void> createExamTable(Database db) async {
    final todoSql = '''CREATE TABLE ${GlobalData.examTableName} (
      ${GlobalData.examNameAttribute} TEXT PRIMARY KEY,
      ${GlobalData.examCfuAttribute} INTEGER,
      ${GlobalData.examMarkAttribute} INTEGER,
      ${GlobalData.examLaudeAttribute} INTEGER)''';
    await db.execute(todoSql);
  }

  //Return database path
  //If it doesn't exist, it will be created
  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    if (!await Directory(dirname(path)).exists()) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  //Open the database or create it if it doesn't exist
  Future<void> initDatabase() async {
    final path = await getDatabasePath(GlobalData.dbName);
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  //on create method used when database isn't created
  Future<void> onCreate(Database db, int version) async {
    await createExamTable(db);
  }
}