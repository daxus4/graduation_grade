import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';

class ShowExamDataPage extends StatefulWidget {
  final Exam _exam;

  ShowExamDataPage(this._exam, {Key key}) : super(key : key);

  @override
  ShowExamDataPageState createState() => ShowExamDataPageState(_exam);
}

class ShowExamDataPageState extends State<ShowExamDataPage> {
  final Exam _exam;

  ShowExamDataPageState(this._exam) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_exam.getName()),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(_exam.getName()),
            SizedBox(
              height: 16,
            ),
            Text(_exam.getCfu().toString()),
            SizedBox(
              height: 16,
            ),
            Text(_exam.isTaken().toString()),
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
                                  await ExamRepository.deleteExam(_exam);
                                  Navigator.of(context).pop();
                                  //TODO: non chiamo setState quindi listview non si aggiorna
                                  //Usare BLoC pattern e usarlo con tutte le chiamate al database
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