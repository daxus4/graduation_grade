import 'package:flutter/material.dart';
import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';

import '../general_data/global_data.dart';
import 'exam_list_view.dart';

class ShowExamsPage extends StatefulWidget {
  final List<Exam> exams;

  ShowExamsPage(this.exams,{Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ShowExamsPageState(exams);
}

class ShowExamsPageState extends State<ShowExamsPage> {
  List<Exam> _exams;

  ShowExamsPageState(this._exams) : super();

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(
        //  icon: Icon(Icons.menu),
        //  tooltip: 'Navigation menu',
        //  onPressed: null,
        //),
        title: Text(GlobalData.appName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add exam',
            onPressed: () async {
              List<Exam> examsUpdated = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExamForm()),
              );
              if(examsUpdated != null) {
                setState(() {
                _exams = examsUpdated;
                });
              }
            },
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Container(
        child: ExamListView(_exams),
      ),
    );
  }
}
