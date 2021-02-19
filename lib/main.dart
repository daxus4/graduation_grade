import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/controller/exams_manager.dart';
import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/model/exams_model.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/show_exam_data_page/show_exam_data_page.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

import 'model/general_data/design_data.dart';
import 'model/general_data/global_data.dart';

final examDbHelper = DbHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*await examDbHelper.initDatabase();
  ExamRepository.setExamsCubit(_examsCubit);
  List<Exam> _exams = await ExamRepository.getExamsFromDb();*/

  ExamsModel examsModel = ExamsModel([]);
  ExamsManager examsManager = ExamsManager(examsModel);


  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home: BlocProvider(
      create: (context) => ExamsCubit(),
      child: ShowExamsPage(examsModel.getExams()),
    ),
    routes: {
      ExamForm.routeName : (context) => BlocProvider(
        create: (context) => ExamsCubit(),
        child: ExamForm(examsManager),
      ),
      ShowExamDataPage.routeName : (context) => ShowExamDataPage(),
    },
  ));
}
