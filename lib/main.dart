import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/db_helper.dart';
import 'file:///C:/Users/Roberto/AndroidStudioProjects/graduation_grade/lib/general_data/design_data.dart';
import 'file:///C:/Users/Roberto/AndroidStudioProjects/graduation_grade/lib/general_data/global_data.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

import 'database_management/exam_repository.dart';
import 'exam/exam.dart';

final examDbHelper = DbHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await examDbHelper.initDatabase();
  List<Exam> _exams = await ExamRepository.getExamsFromDb();
  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home:  ShowExamsPage(_exams),
    ),
  );
}
