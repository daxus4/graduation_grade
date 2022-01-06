import 'dart:async';
import 'dart:io';

import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Used by [ExamRepository] to perform SQL requests.
Database db;

/// Class that manage a [Database] that contains the information about [Exam]
/// instances.
class DbHelper {
  /// Create the table of [Exam] instances.
  Future<void> createExamTable(Database db) async {
    final todoSql = '''CREATE TABLE ${GlobalData.examTableName} (
      ${GlobalData.examNameAttribute} TEXT PRIMARY KEY,
      ${GlobalData.examCfuAttribute} INTEGER,
      ${GlobalData.examMarkAttribute} INTEGER,
      ${GlobalData.examLaudeAttribute} INTEGER)''';
    await db.execute(todoSql);
  }

  /// Return the [Database] path. If the database doesn't exist, it will be
  /// created.
  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    if (!await Directory(dirname(path)).exists()) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  /// Open the [Database] or create it if it doesn't exist.
  Future<void> initDatabase() async {
    final path = await getDatabasePath(GlobalData.dbName);
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    //print(db);
  }

  /// This is onCreate method used by [openDatabase()] when [Database] have to
  /// be created.
  Future<void> onCreate(Database db, int version) async {
    await createExamTable(db);
  }
}
