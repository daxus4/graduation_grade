import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/exams_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';
import 'package:graduation_grade/show_exam_data_page/update_exam_dialog.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

class ShowExamDataPage extends StatefulWidget {
  static const routeName = '/showExamData';

  final Observer<ExamMessage> examController;

  ShowExamDataPage(this.examController) : super();

  @override
  _ShowExamDataPageState createState() =>
      _ShowExamDataPageState(_ObservableExamMessage([examController]));
}

class _ObservableExamMessage extends Observable<ExamMessage> {
  _ObservableExamMessage(List<Observer<ExamMessage>> observers)
      : super(observers);
}

class _ShowExamDataPageState extends State<ShowExamDataPage> {
  final _ObservableExamMessage _observableFromController;

  _ShowExamDataPageState(this._observableFromController) : super();

  @override
  Widget build(BuildContext context) {
    Exam exam = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.getName()),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ExamsCubit, ExamsState>(
          listener: (context, state) {
            if (state is ExamDeleted)
              Navigator.popUntil(
                  context, ModalRoute.withName(ShowExamsPage.routeName));
          },
          builder: (context, state) {
            if (state is ExamTaken) {
              //If updated exam is the same exam show in this page
              if (state.getExam().getName() == exam.getName()) {
                return page(state.getExam(), context);
              }
            }
            //Else
            return page(exam, context);
          },
        ),
      ),
    );
  }

  void updateAfterDeleteExam(String name) {
    BlocProvider.of<ExamsCubit>(this.context).updateDeletingExam(name);
  }

  void updateAfterTakeExam(Exam e) {
    BlocProvider.of<ExamsCubit>(this.context).updateTakenExam(e);
  }

  Widget page(Exam exam, BuildContext context) {
    return Column(
      children: <Widget>[
        Text(exam.getName()),
        SizedBox(
          height: 16,
        ),
        Text(AppLocalizations.of(context).translate("cfu") +
            ": " +
            exam.getCfu().toString()),
        SizedBox(
          height: 16,
        ),
        Text(exam.isTaken().toString()),
        SizedBox(
          height: 16,
        ),
        Text(
          exam.isTaken()
              ? AppLocalizations.of(context).translate("mark") +
                  ": " +
                  exam.getMark().toString()
              : AppLocalizations.of(context).translate('no_mark'),
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
              AppLocalizations.of(context).translate('laude') + ":",
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
                  title: Text(AppLocalizations.of(context).translate("delete")),
                  content: Text(
                      AppLocalizations.of(context).translate("delete_quest")),
                  actions: <Widget>[
                    TextButton(
                      child: Text(AppLocalizations.of(context).translate("no")),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child:
                          Text(AppLocalizations.of(context).translate("yes")),
                      onPressed: () {
                        _observableFromController.notify(
                            DeleteExamMessage(exam, updateAfterDeleteExam));
                      },
                    ),
                  ],
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context).translate("delete"),
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
                    content: Text(AppLocalizations.of(context)
                        .translate("no_insert_exam"))));
                return;
              }
              showDialog(
                  context: context,
                  builder: (BuildContext context) => UpdateExamDialog(exam,
                      _observableFromController.notify, updateAfterTakeExam));
            },
            child: Text(
              AppLocalizations.of(context).translate("take"),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ],
    );
  }
}
