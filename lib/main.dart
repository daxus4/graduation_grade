import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/controller/exams_manager.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/show_exam_data_page/show_exam_data_page.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

import 'model/general_data/design_data.dart';
import 'model/general_data/global_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ExamsManager examsManager = ExamsManager();
  await examsManager.init();

  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home: BlocProvider(
      create: (context) => ExamsCubit(),
      child: ShowExamsPage(examsManager.getModel().getExams()),
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
