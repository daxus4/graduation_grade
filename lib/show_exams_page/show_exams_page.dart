import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/cubit/exams_cubit.dart';
import 'package:graduation_grade/cubit/exams_state.dart';
import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';

import '../general_data/global_data.dart';
import 'exam_list_view.dart';

class ShowExamsPage extends StatefulWidget {
  final List<Exam> exams;

  ShowExamsPage(this.exams, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ShowExamsPageState(exams);
}

class ShowExamsPageState extends State<ShowExamsPage> {
  List<Exam> _exams;

  ShowExamsPageState(this._exams) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalData.appName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add exam',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExamForm()),
              );
            },
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Container(
          child: BlocConsumer<ExamsCubit, ExamsState>(
            listener: (context, state) {
              if (state is ExamsError)
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
            },
            builder: (context, state) {
              if (state is ExamsInitial)
                return ExamListView(_exams);
              else if (state is ExamsLoaded) {
                _exams = state.getExams();
                return ExamListView(_exams);
              } else {
                //When state is error
                return ExamListView(<Exam>[]);
              }
            },
          )
      ),
    );
  }
}
