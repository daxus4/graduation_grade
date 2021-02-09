import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';

class ShowExamDataPage extends StatefulWidget {
  static const routeName = '/showExamData';

  @override
  ShowExamDataPageState createState() => ShowExamDataPageState();
}

class ShowExamDataPageState extends State<ShowExamDataPage> {

  @override
  Widget build(BuildContext context) {
    final Exam exam = ModalRoute.of(context).settings.arguments;
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
            Row(
              children: <Widget>[
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
                                  Navigator.popUntil(context,ModalRoute.withName('/'));
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
                  onPressed: () {  },
                  child: Text(
                    "Modify",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}