import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/global_data.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';
//TODO command pattern per non chiamare db
class ExamRepository {
  //SQL insert of a exam
  static Future<void> addArticle(Exam exam) async {
    await db.insert(GlobalData.examTableName, exam.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Retrieve list of all exams in the database
  static Future<List<Exam>> getExamsFromDb() async {
    //Query the table
    final List<Map<String, dynamic>> maps =
      await db.query(GlobalData.examTableName);

    //Convert List<Map> in List<Exam>
    return List.generate(maps.lenght, (i) {
      //TODO sfruttare pattern
      if(maps[i][GlobalData.examMarkAttribute] == 0)
        return Exam.fromMapObject(maps[i]);
      else
        return PassedExam.fromMapObject(maps[i]);
    });
  }


}