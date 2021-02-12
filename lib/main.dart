import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/show_exam_data_page/show_exam_data_page.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';
import 'database_management/exam_repository.dart';
import 'exam/exam.dart';
import 'general_data/design_data.dart';
import 'general_data/global_data.dart';

final examDbHelper = DbHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await examDbHelper.initDatabase();
  ExamsCubit _examsCubit= ExamsCubit();
  ExamRepository.setExamsCubit(_examsCubit);
  List<Exam> _exams = await ExamRepository.getExamsFromDb();
  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home: BlocProvider(
      create: (context) => _examsCubit,
      child: ShowExamsPage(_exams),
    ),
    routes: {
      ExamForm.routeName : (context) => ExamForm(),
      ShowExamDataPage.routeName : (context) => ShowExamDataPage(),
    },
  ));
}
