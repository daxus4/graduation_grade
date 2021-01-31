import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/exam/exam_base.dart';
import 'package:graduation_grade/exam/passed_exam.dart';

class ExamForm extends StatefulWidget {
  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  String _examName= "";
  int _examCfu,_examMark;
  bool _cumLaude = false;
  final _formKey = GlobalKey<FormState>();

  FocusNode _examNameFocusNode;
  FocusNode _examCfuFocusNode;
  FocusNode _examMarkFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            examNameInput(),
            SizedBox(height: 16,),
            examCfuInput(),
            SizedBox(height: 16,),
            examMarkInput(),
            SizedBox(height: 16,),
            examLaudeInput(),
            SizedBox(height: 16,),
            submitButton(context)
          ],
        ),
      ),
    );
  }


  Widget examNameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text ,
      decoration: InputDecoration(
        labelText: "Exam name",
        hintText: "Physic 101",
      ),
      textInputAction: TextInputAction.next,
      validator: (name){
        Pattern pattern =
            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        return !regex.hasMatch(name) ? 'Invalid exam name' : null;

      },
      onSaved: (name)=> _examName = name,
      focusNode: _examNameFocusNode,
      autofocus: true,
      onFieldSubmitted: (_){
        fieldFocusChange(context, _examNameFocusNode, _examCfuFocusNode);
      },
    );
  }

  Widget examCfuInput() {
    return TextFormField(
      keyboardType: TextInputType.number ,
      decoration: InputDecoration(
        labelText: "Exam CFU",
        hintText: "10",
      ),
      textInputAction: TextInputAction.next,
      validator: (cfu){
        if(cfu.isEmpty)
          return 'Invalid CFU number';
        int intCfu = int.parse(cfu);
        return (intCfu > 0 && intCfu <= 100) ? null : 'Invalid CFU number';
      },
      onSaved: (cfu)=> _examCfu = int.parse(cfu),
      focusNode: _examCfuFocusNode,
      onFieldSubmitted: (_){
        fieldFocusChange(context, _examCfuFocusNode, _examMarkFocusNode);
      },
    );
  }

  Widget examMarkInput() {
    return TextFormField(
      keyboardType: TextInputType.number ,
      decoration: InputDecoration(
        labelText: "Exam Mark",
        hintText: "From 18 to 30",
      ),
      textInputAction: TextInputAction.done,
      validator: (mark){
        if(mark.isEmpty)
          return 'Invalid mark';
        int intMark = int.parse(mark);
        if (intMark >= 18 && intMark <= 30) {
          if (_cumLaude && intMark != 30)
            return 'Laude must be with 30';
          return null;
        }
        return 'Invalid mark';
      },
      onSaved: (mark)=> _examMark = int.parse(mark),
      focusNode: _examMarkFocusNode,
    );
  }

  Widget examLaudeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Laude:'),
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


  ElevatedButton submitButton(BuildContext context){
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor, // background
      ),
      onPressed: () async {
        if(_formKey.currentState.validate()){
          _formKey.currentState.save();
          log('$_examName, $_examCfu, $_examMark, $_cumLaude');
          ExamRepository.addExam(
              PassedExam(ExamBase(_examName, _examCfu), _examMark, _cumLaude));
          final List<Exam> exams = await ExamRepository.getExamsFromDb();
          log(exams.toString());
        }
      },
      child: Text("Submit",style: TextStyle(color: Colors.white),),
    );
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
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