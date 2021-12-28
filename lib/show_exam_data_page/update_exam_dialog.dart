import 'package:flutter/material.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/mark_exam_message.dart';

class UpdateExamDialog extends StatefulWidget {
  final Exam _exam;

  final Function(ExamMessage) _updateExamFunction;
  final Function(Exam) _updateAfterTakeExam;

  const UpdateExamDialog(
      this._exam, this._updateExamFunction, this._updateAfterTakeExam,
      {Key key})
      : super(key: key);

  @override
  _UpdateExamDialogState createState() =>
      _UpdateExamDialogState(_exam, _updateExamFunction, _updateAfterTakeExam);
}

class _UpdateExamDialogState extends State<UpdateExamDialog> {
  final Exam _exam;

  bool _cumLaude = false;
  int _examMark;

  final _formKey = GlobalKey<FormState>();

  final Function(ExamMessage) _updateExamFunction;
  final Function(Exam) _updateAfterTakeExam;

  _UpdateExamDialogState(
      this._exam, this._updateExamFunction, this._updateAfterTakeExam)
      : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate("take")),
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
          child: Text(AppLocalizations.of(context).translate("cancel")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        updateButton(context),
      ],
    );
  }

  //TextForm in which insert the exam mark
  Widget examMarkInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate("exam_mark"),
        hintText: AppLocalizations.of(context).translate("range_marks"),
      ),
      textInputAction: TextInputAction.done,
      validator: (mark) {
        if (mark.isEmpty)
          return AppLocalizations.of(context).translate('inv_mark');
        int intMark = int.parse(mark);
        if (intMark >= 18 && intMark <= 30) {
          if (_cumLaude && intMark != 30)
            return AppLocalizations.of(context).translate("err_laude");
          return null;
        }
        return AppLocalizations.of(context).translate('inv_mark');
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
          AppLocalizations.of(context).translate('laude') + ":",
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
  TextButton updateButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _updateExamFunction(MarkExamMessage(
              Exam.taken(_exam.getName(), _exam.getCfu(), _examMark, _cumLaude),
              _updateAfterTakeExam));
          Navigator.pop(context);
        }
      },
      child: Text(
        AppLocalizations.of(context).translate("update"),
      ),
    );
  }
}
