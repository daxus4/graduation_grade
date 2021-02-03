//Form in which insert the data of exams
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';

class ExamForm extends StatefulWidget {
  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  String _examName = "";
  int _examCfu, _examMark;
  bool _cumLaude = false;
  bool _alreadyTaken = false;

  final _formKey = GlobalKey<FormState>();

  FocusNode _examNameFocusNode;
  FocusNode _examCfuFocusNode;
  FocusNode _examMarkFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert exam"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              examNameInput(),
              SizedBox(
                height: 16,
              ),
              examCfuInput(),
              SizedBox(
                height: 16,
              ),
              alreadyTakenInput(),
              SizedBox(
                height: 16,
              ),
              examMarkInput(),
              SizedBox(
                height: 16,
              ),
              examLaudeInput(),
              SizedBox(
                height: 16,
              ),
              submitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  //TextForm in which insert the exam name
  Widget examNameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Exam name",
        hintText: "Physic 101",
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        return !regex.hasMatch(name) ? 'Invalid exam name' : null;
      },
      onSaved: (name) => _examName = name,
      focusNode: _examNameFocusNode,
      autofocus: true,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _examNameFocusNode, _examCfuFocusNode);
      },
    );
  }

  //TextForm in which insert the exam cfu
  Widget examCfuInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Exam CFU",
        hintText: "10",
      ),
      textInputAction: TextInputAction.next,
      validator: (cfu) {
        if (cfu.isEmpty) return 'Invalid CFU number';
        int intCfu = int.parse(cfu);
        return (intCfu > 0 && intCfu <= 100) ? null : 'Invalid CFU number';
      },
      onSaved: (cfu) => _examCfu = int.parse(cfu),
      focusNode: _examCfuFocusNode,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _examCfuFocusNode, _examMarkFocusNode);
      },
    );
  }

  //Checkbox in which insert if you get laude in your exam
  Widget alreadyTakenInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Already taken:'),
        Checkbox(
          value: _alreadyTaken,
          onChanged: (bool value) {
            setState(() {
              _alreadyTaken = value;
            });
          },
        ),
      ],
    );
  }

  //TextForm in which insert the exam mark
  Widget examMarkInput() {
    return TextFormField(
      enabled: _alreadyTaken,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Exam Mark",
        hintText: "From 18 to 30",
      ),
      textInputAction: TextInputAction.done,
      validator: (mark) {
        if (!_alreadyTaken) return null;
        if (mark.isEmpty) return 'Invalid mark';
        int intMark = int.parse(mark);
        if (intMark >= 18 && intMark <= 30) {
          if (_cumLaude && intMark != 30) return 'Laude must be with 30';
          return null;
        }
        return 'Invalid mark';
      },
      onSaved: (mark) {
        if (_alreadyTaken) _examMark = int.parse(mark);
      },
      focusNode: _examMarkFocusNode,
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
            color: _alreadyTaken ? Colors.black : Colors.grey,
          ),
        ),
        Checkbox(
          value: _cumLaude,
          onChanged: (bool value) {
            if (!_alreadyTaken) return null;
            setState(() {
              _cumLaude = value;
            });
          },
        ),
      ],
    );
  }

  //Button that insert in the database the data typed by user
  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor, // background
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if (_alreadyTaken) {
            log('$_examName, $_examCfu, $_examMark, $_cumLaude');
            ExamRepository.addExam(
                Exam.taken(_examName, _examCfu, _examMark, _cumLaude));
          } else {
            log('$_examName, $_examCfu');
            ExamRepository.addExam(Exam(_examName, _examCfu));
          }
          final List<Exam> exams = await ExamRepository.getExamsFromDb();
          log(exams.toString());
          Navigator.pop(context);
        }
      },
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
    _examNameFocusNode = FocusNode();
    _examCfuFocusNode = FocusNode();
    _examMarkFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _examNameFocusNode.dispose();
    _examCfuFocusNode.dispose();
    _examMarkFocusNode.dispose();
    super.dispose();
  }
}
