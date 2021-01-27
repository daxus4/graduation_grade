import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/global_data.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class ExamRepository {
  static Future<void> addArticle(Exam exam) async {
    await db.insert(GlobalData.examTableName, exam.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}