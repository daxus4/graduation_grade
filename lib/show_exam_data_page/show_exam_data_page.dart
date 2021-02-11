import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/general_data/global_data.dart';
import 'package:graduation_grade/show_exam_data_page/update_exam_dialog.dart';

class ShowExamDataPage extends StatefulWidget {
  static const routeName = '/showExamData';

  @override
  ShowExamDataPageState createState() => ShowExamDataPageState();
}

class ShowExamDataPageState extends State<ShowExamDataPage> {

  bool firstTime = true;
  Exam exam;

  @override
  Widget build(BuildContext context) {

    if(firstTime)
      exam = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.getName()),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(exam.getName()),
            SizedBox(
              height: 16,
            ),
            Text(exam.getCfu().toString()),
            SizedBox(
              height: 16,
            ),
            Text(exam.isTaken().toString()),
            SizedBox(
              height: 16,
            ),
            Text(
              exam.isTaken() ? 'Mark: ${exam.getMark()}' : 'Mark: none',
              style: TextStyle(
                color: exam.isTaken() ? Colors.black : Colors.grey,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Laude:',
                  style: TextStyle(
                    color: exam.isTaken() ? Colors.black : Colors.grey,
                  ),
                ),
                Checkbox(
                  value: exam.isTaken() ? exam.getLaude() : false,
                  onChanged: (bool value) {},
                ),
              ],
            ),
            Row(children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor, // background
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Delete"),
                      content: Text("Are you sure to delete this exam?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            await ExamRepository.deleteExam(exam);
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor, // background
                ),
                onPressed: () async {
                  if (exam.isTaken()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "You cannot insert a mark in a already taken exam")));
                    return;
                  }
                  Map<String, dynamic> examChanges = await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => UpdateExamDialog());
                  if (examChanges.isNotEmpty) {
                    ExamRepository.updateExam(Exam.taken(
                        exam.getName(),
                        exam.getCfu(),
                        examChanges[GlobalData.examMarkAttribute],
                        examChanges[GlobalData.examLaudeAttribute]));
                    setState(() {
                      firstTime = false;
                      exam = Exam.taken(
                          exam.getName(),
                          exam.getCfu(),
                          examChanges[GlobalData.examMarkAttribute],
                          examChanges[GlobalData.examLaudeAttribute]);
                    });
                  }
                },
                child: Text(
                  "Take",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
