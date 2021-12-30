import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/form_exam/exam_form.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/exams_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';

import 'exam_list_view.dart';

/// Page that contains a [ExamListView] that shows every [Exam].
class ShowExamsPage extends StatefulWidget {

  /// Route of this page.
  static const routeName = '/showExams';

  /// List of [Exam] present in the current state.
  final List<Exam> exams;

  /// This is the controller, passed as an [Observer] of [Message] because
  /// it have to be notified when a [DeleteExamMessage] or a
  /// [MarkExamMessage] are thrown.
  final Observer<Map<String, Function>> examController;

  /// Constructor that require the list of [Exam] and a [Observer] of [Message].
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

  void updateAfterChange(Message message) {
    BlocProvider.of<ExamsCubit>(this.context).getExams(message);
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
            tooltip: AppLocalizations.of(context).translate('add_exam'),
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
