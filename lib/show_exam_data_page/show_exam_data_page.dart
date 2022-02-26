import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/design_data.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/exams_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';
import 'package:graduation_grade/show_exam_data_page/update_exam_dialog.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

/// Page where there are shown the information about an [Exam].
class ShowExamDataPage extends StatefulWidget {
  /// Route of this page.
  static const routeName = '/showExamData';

  /// This is the controller, passed as an [Observer] of [Message] because
  /// it have to be notified when a [DeleteExamMessage] or a
  /// [MarkExamMessage] are thrown.
  final Observer<Message> examController;

  /// Constructor that require the [Observer] of [Message].
  ShowExamDataPage(this.examController) : super();

  @override
  _ShowExamDataPageState createState() =>
      _ShowExamDataPageState(_ObservableExamMessage([examController]));
}

class _ObservableExamMessage extends Observable<Message> {
  _ObservableExamMessage(List<Observer<Message>> observers) : super(observers);
}

class _ShowExamDataPageState extends State<ShowExamDataPage> {
  final _ObservableExamMessage _observableFromController;

  _ShowExamDataPageState(this._observableFromController) : super();

  @override
  Widget build(BuildContext context) {
    Exam exam = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalData.appName),
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
        Expanded(
          child: Column(
            children: <Widget>[
              examNameText(exam.getName().toUpperCase()),
              SizedBox(height: 10,),
              examCfuText(exam.getCfu()),
              SizedBox(height: 10,),
              exam.isTaken() ?
              rowMark(exam.getMark(), exam.getLaude(), true) :
              rowMark(0, false, false),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          flex:8
        ),
        Expanded(child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: DesignData.secondaryColor, // background
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
              SizedBox(width: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: DesignData.secondaryColor, // background
            ),
            onPressed: () async {
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
              SizedBox(width: 4,),
        ]),
        flex: 2),
      ],
    );
  }

  Widget rowNameCfu(Exam exam) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        examNameText(exam.getName().toUpperCase()),
        examCfuText(exam.getCfu()),
      ],
    );
  }

  Widget examNameText(String degreeName) {
    return AutoSizeText(
        degreeName,
        style: TextStyle(fontSize: 40),
        minFontSize: 25,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
    );
  }

  Widget examCfuText(int cfu) {
    return AutoSizeText(
          cfu.toString() + " " +
              AppLocalizations.of(context).translate("cfu").toUpperCase(),
          style: TextStyle(fontSize: 30),
          minFontSize: 18,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
    );
  }

  Widget rowMark(int mark, bool laude, bool isTaken){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isTaken ? [
        Expanded(
          child: AutoSizeText(
            AppLocalizations.of(context).translate("mark").toUpperCase() + ":",
            style: TextStyle(fontSize: 30),
            minFontSize: 18,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: AutoSizeText(
            laude ? mark.toString() + "L" : mark.toString(),
            style: TextStyle(fontSize: 30),
            minFontSize: 18,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ] : [
        Expanded(
          child: AutoSizeText(
            AppLocalizations.of(context).translate("mark").toUpperCase() + ":",
            style: TextStyle(fontSize: 30, color: Colors.grey),
            minFontSize: 18,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
