import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';

//TODO: create class dialog stateful for update exam and non farlo con esami già dati

class ShowExamDataPage extends StatefulWidget {
  static const routeName = '/showExamData';

  @override
  ShowExamDataPageState createState() => ShowExamDataPageState();
}

class ShowExamDataPageState extends State<ShowExamDataPage> {
  final _formKey = GlobalKey<FormState>();
  bool _cumLaude = false;
  int _examMark;

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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Take"),
                      content: Container(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                examMarkInput(),
                                SizedBox(
                                  height: 16,
                                ),
                                examLaudeInput(),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        updateButton(context, exam),
                      ],
                    ),
                  );
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

  //TextForm in which insert the exam mark
  Widget examMarkInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Exam Mark",
        hintText: "From 18 to 30",
      ),
      textInputAction: TextInputAction.done,
      validator: (mark) {
        if (mark.isEmpty) return 'Invalid mark';
        int intMark = int.parse(mark);
        if (intMark >= 18 && intMark <= 30) {
          if (_cumLaude && intMark != 30) return 'Laude must be with 30';
          return null;
        }
        return 'Invalid mark';
      },
      onSaved: (mark) => _examMark = int.parse(mark),
    );
  }

  //Checkbox in which insert if you get laude in your exam
  Widget examLaudeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Laude:',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Checkbox(
          value: _cumLaude,
          onChanged: (bool value) {
            setState(() {
              _cumLaude = value;
            });
          },
        ),
      ],
    );
  }

  //Button that insert in the database the data typed by user
  TextButton updateButton(BuildContext context, Exam e) {
    return TextButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          log('${e.getName()}, ${e.getCfu()}, $_examMark, $_cumLaude');
          ExamRepository.updateExam(
              Exam.taken(e.getName(), e.getCfu(), _examMark, _cumLaude));
          Navigator.pop(context);
        }
      },
      child: Text(
        "Update",
      ),
    );
  }
}
