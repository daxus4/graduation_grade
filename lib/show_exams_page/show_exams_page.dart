import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/exams_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';

import 'exam_list_view.dart';

class ShowExamsPage extends StatefulWidget {
  static const routeName = '/showExams';

  final List<Exam> exams;

  final Observer<Map<String, Function>> examController;

  ShowExamsPage(this.exams, this.examController, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ShowExamsPageState(
      exams, _ObservableUpdateFunction([examController]));
}

class _ObservableUpdateFunction extends Observable<Map<String, Function>> {
  _ObservableUpdateFunction(List<Observer<Map<String, Function>>> observers)
      : super(observers);
}

class ShowExamsPageState extends State<ShowExamsPage> {
  List<Exam> _exams;

  final _ObservableUpdateFunction _observableFromController;

  ShowExamsPageState(this._exams, this._observableFromController) : super() {
    _observableFromController
        .notify({ShowExamsPage.routeName: updateAfterChange});
  }

  void updateAfterChange(ExamMessage examMessage) {
    BlocProvider.of<ExamsCubit>(this.context).getExams(examMessage);
  }

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
