import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:graduation_grade/pattern/command/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/exams_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';
import 'package:graduation_grade/show_exam_data_page/update_exam_dialog.dart';

class ShowExamDataPage extends StatefulWidget {
  static const routeName = '/showExamData';

  final Observer<ExamMessage> examController;

  ShowExamDataPage(this.examController) : super();

  @override
  _ShowExamDataPageState createState() => _ShowExamDataPageState(_ObservableExamMessage([examController]));
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
            if(state is ExamDeleted)
              Navigator.popUntil(
                  context, ModalRoute.withName('/'));
          },
          builder: (context, state) {
            if (state is ExamUpdated) {
              //If updated exam is the same exam show in this page
              if (state.getExam().getName() == exam.getName()) {
                return page(state.getExam());
              }
            }
            //Else
            return page(exam);
          },
        ),
      ),
    );
  }

  void updateAfterDeleteExam(String name) {
    BlocProvider.of<ExamsCubit>(this.context).updateDeletingExam(name);
  }

  Widget page(Exam exam) {
    return Column(
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
                  context: context,
                  builder: (BuildContext context) => UpdateExamDialog());
              if (examChanges != null && examChanges.isNotEmpty) {
                ExamRepository.updateExam(Exam.taken(
                    exam.getName(),
                    exam.getCfu(),
                    examChanges[GlobalData.examMarkAttribute],
                    examChanges[GlobalData.examLaudeAttribute]));
                setState(() {
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
    );
  }
}
