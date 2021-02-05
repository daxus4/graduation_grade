import 'package:flutter/material.dart';
import 'package:graduation_grade/exam/exam.dart';
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
            subtitle = 'CFU: ${exams[i].getCfu()}, Mark: ${exams[i].getMark()}';
            if (exams[i].getLaude()) subtitle = subtitle + ' with laude';
          } else
            subtitle = 'CFU: ${exams[i].getCfu()}';
          return ListTile(
            title: Text('${exams[i].getName()}'),
            subtitle: Text(subtitle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowExamDataPage(exams[i])),
              );
            },
          );
        });
  }
}
