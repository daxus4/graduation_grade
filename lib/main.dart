import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_grade/controller/exams_manager.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/information_cubit.dart';
import 'package:graduation_grade/show_exam_data_page/show_exam_data_page.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

import 'app_localizations/app_localizations.dart';
import 'homepage/homepage.dart';
import 'model/general_data/design_data.dart';
import 'model/general_data/global_data.dart';

/// Main function of the application. Initialize the controller and the model
/// and execute [runApp()].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ExamsManager examsManager = ExamsManager();
  await examsManager.init();

  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home: BlocProvider(
      create: (context) => InformationCubit(),
      child: HomePage(
          examsManager,
          examsManager.getObserverOfUpdateFunctions(),
          examsManager.getModel().getWAvg(),
          examsManager.getModel().getCfuAcquired(),
          examsManager.getModel().getExpectedGrade(),
          examsManager.getModel().getDegreeName()),
    ),
    routes: {
      ShowExamsPage.routeName: (context) => BlocProvider(
            create: (context) => ExamsCubit(),
            child: ShowExamsPage(examsManager.getModel().getExams(),
                examsManager.getObserverOfUpdateFunctions()),
          ),
      ExamForm.routeName: (context) => BlocProvider(
            create: (context) => ExamsCubit(),
            child: ExamForm(examsManager),
          ),
      ShowExamDataPage.routeName: (context) => BlocProvider(
            create: (context) => ExamsCubit(),
            child: ShowExamDataPage(examsManager),
          ),
    },
    supportedLocales: [
      Locale('en', 'US'),
      Locale('it', 'IT'),
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode)
          return supportedLocale;
      }
      return supportedLocales.first;
    },
  ));
}
