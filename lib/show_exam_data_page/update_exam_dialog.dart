import 'package:flutter/material.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/take_exam_message.dart';

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
  TextButton updateButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _updateExamFunction(TakeExamMessage(
              Exam.taken(_exam.getName(), _exam.getCfu(), _examMark, _cumLaude),
              _updateAfterTakeExam));
          Navigator.pop(context);
        }
      },
      child: Text(
        "Update",
      ),
    );
  }
}
