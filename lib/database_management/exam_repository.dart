import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

//TODO command pattern per non chiamare db

/// Class that make SQL requests to [Database] of [Exam] instances in order to
/// add, modify, show or delete the exams.
class ExamRepository {
  /// SQL insert of a [Exam].
  static Future<void> addExam(Exam exam) async {
    await db.insert(GlobalData.examTableName, exam.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Retrieve list of all [Exam] instances in the database.
  static Future<List<Exam>> getExamsFromDb() async {
    //Query the table
    final List<Map<String, dynamic>> maps =
        await db.query(GlobalData.examTableName);

    //Convert List<Map> in List<Exam>
    return List.generate(maps.length, (i) {
      if (maps[i][GlobalData.examMarkAttribute] != 0)
        return Exam.taken(
            maps[i][GlobalData.examNameAttribute],
            maps[i][GlobalData.examCfuAttribute],
            maps[i][GlobalData.examMarkAttribute],
            maps[i][GlobalData.examLaudeAttribute] == 0 ? false : true);
      return Exam(maps[i][GlobalData.examNameAttribute],
          maps[i][GlobalData.examCfuAttribute]);
    });
  }

  /// SQL update of an [Exam].
  static Future<void> updateExam(Exam exam) async {
    await db.update(
      GlobalData.examTableName,
      exam.toMap(),

      //Ensure that the Exam has a matching id
      where: "${GlobalData.examNameAttribute} = ?",

      //Prevent SQL injection
      whereArgs: [exam.getName()],
    );
  }

  /// SQL deletion of an [Exam].
  static Future<void> deleteExam(Exam exam) async {
    await db.delete(
      GlobalData.examTableName,

      //Ensure that the Exam has a matching id
      where: "${GlobalData.examNameAttribute} = ?",

      //Prevent SQL injection
      whereArgs: [exam.getName()],
    );
  }
}
