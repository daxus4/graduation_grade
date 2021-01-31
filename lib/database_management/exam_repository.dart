//Class that make SQL request to database in order to add, modify, show or
//delete the exams

import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/exam/exam_base.dart';
import 'package:graduation_grade/exam/passed_exam.dart';
import 'package:graduation_grade/global_data.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

//TODO command pattern per non chiamare db
class ExamRepository {
  //SQL insert of a exam
  static Future<void> addExam(Exam exam) async {
    await db.insert(GlobalData.examTableName, exam.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Retrieve list of all exams in the database
  static Future<List<Exam>> getExamsFromDb() async {
    //Query the table
    final List<Map<String, dynamic>> maps =
        await db.query(GlobalData.examTableName);

    //Convert List<Map> in List<Exam>
    return List.generate(maps.length, (i) {
      Exam exam = ExamBase.fromMapObject(maps[i]);
      if (maps[i][GlobalData.examMarkAttribute] != 0)
        exam = PassedExam(exam, maps[i][GlobalData.examMarkAttribute],
            maps[i][GlobalData.examLaudeAttribute] == 0 ? false : true);
      return exam;
    });
  }

  //SQL update of an exam
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

  //SQL deletion of an exam
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
