import 'package:flutter/material.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/show_exam_data_page/show_exam_data_page.dart';

class ExamListView extends StatelessWidget {
  final List<Exam> exams;

  ExamListView(this.exams, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, i) {
          String subtitle;
          if (exams[i].isTaken()) {
            subtitle = AppLocalizations.of(context).translate("cfu") +
                ": " +
                exams[i].getCfu().toString() +
                ", " +
                AppLocalizations.of(context).translate("mark") +
                ": " +
                exams[i].getMark().toString();
            if (exams[i].getLaude())
              subtitle = subtitle +
                  AppLocalizations.of(context).translate("cum_laude");
          } else
            subtitle = AppLocalizations.of(context).translate("cfu") +
                ": " +
                exams[i].getCfu().toString();
          return ListTile(
            title: Text('${exams[i].getName()}'),
            subtitle: Text(subtitle),
            onTap: () {
              Navigator.pushNamed(
                context,
                ShowExamDataPage.routeName,
                arguments: exams[i],
              );
            },
          );
        });
  }
}
