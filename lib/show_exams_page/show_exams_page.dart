import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/exams_state.dart';

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

  void updateAfterAddedExam(Exam exam) {
    BlocProvider.of<ExamsCubit>(this.context).updateWithNewExam(exam);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalData.appName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add exam',
            onPressed: () {
              Navigator.pushNamed(
                context,
                ExamForm.routeName,
                arguments: updateAfterAddedExam,
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
              return ExamListView(_exams);
            },
          ),
      ),
    );
  }
}
