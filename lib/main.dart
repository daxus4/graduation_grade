import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/show_exam_data_page/show_exam_data_page.dart';
import 'package:graduation_grade/show_exams_page/exam_controller.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';
import 'general_data/design_data.dart';
import 'general_data/global_data.dart';

final examDbHelper = DbHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ExamsCubit _examsCubit = ExamsCubit();

  /*await examDbHelper.initDatabase();
  ExamRepository.setExamsCubit(_examsCubit);
  List<Exam> _exams = await ExamRepository.getExamsFromDb();*/

  ExamController examController = ExamController([], _examsCubit);
  /*List<Exam> clonedExams = List<Exam>.generate(examController.getExams().length,
          (i) => examController.getExams()[i].copy());*/

  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home: BlocProvider(
      create: (context) => _examsCubit,
      child: ShowExamsPage(examController.getExams()),
    ),
    routes: {
      ExamForm.routeName : (context) => BlocProvider(
        create: (context) => _examsCubit,
        child: ExamForm(examController),
      ),
      ShowExamDataPage.routeName : (context) => ShowExamDataPage(),
    },
  ));
}
