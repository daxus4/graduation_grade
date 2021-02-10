//Form in which insert the data of exams
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';

class TakeExamDialog extends StatefulWidget {
  final String _name;
  final int _cfu;

  TakeExamDialog(this._name, this._cfu) : super();

  @override
  _TakeExamDialogState createState() => _TakeExamDialogState(_name, _cfu);
}

class _TakeExamDialogState extends State<TakeExamDialog> {
  final String _name;
  final int _cfu;

  _TakeExamDialogState(this._name, this._cfu) : super();

  int _examMark;
  bool _cumLaude = false;

  final _formKey = GlobalKey<FormState>();

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
                updateButton(context)
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
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
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          log('$_name, $_cfu, $_examMark, $_cumLaude');
          ExamRepository.updateExam(
              Exam.taken(_name, _cfu, _examMark, _cumLaude));
          Navigator.pop(context);
        }
      },
      child: Text(
        "Update",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
