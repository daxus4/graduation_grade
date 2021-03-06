//Form in which insert the data of exams
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/cubit/exams_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';

class ExamForm extends StatefulWidget {
  static const routeName = '/examForm';

  final Observer<ExamMessage> examController;

  ExamForm(this.examController) : super();

  @override
  _ExamFormState createState() =>
      _ExamFormState(_ObservableExamMessage([examController]));
}

class _ObservableExamMessage extends Observable<ExamMessage> {
  _ObservableExamMessage(List<Observer<ExamMessage>> observers)
      : super(observers);
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

  final _ObservableExamMessage _observableFromController;

  _ExamFormState(this._observableFromController) : super();

  void requestAnotherExam(String name) {
    BlocProvider.of<ExamsCubit>(this.context).requestAnotherExam(
        name, AppLocalizations.of(context).translate("exam_named") + name + AppLocalizations.of(context).translate(" is already present, insert another"));
  }

  void updateAfterAddExam(Exam e) {
    BlocProvider.of<ExamsCubit>(this.context).updateWithNewExam(e);
  }

  @override
  Widget build(BuildContext context) {
    final Function(Exam) updateShowExamsPageFunction =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("ins_exam")),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ExamsCubit, ExamsState>(
          listener: (context, state) {
            if (state is ExamAlreadyPresent)
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.getMessage())));
            else if (state is ExamAdded) Navigator.pop(context);
          },
          builder: (context, state) => Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                  submitButton(context, updateShowExamsPageFunction),
                ],
              ),
            ),
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
        labelText: AppLocalizations.of(context).translate("exam_name"),
        hintText: AppLocalizations.of(context).translate("exam_ex"),
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        return !regex.hasMatch(name) ? AppLocalizations.of(context).translate('inv_e_name') : null;
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
        labelText: AppLocalizations.of(context).translate("cfu"),
        hintText: "10",
      ),
      textInputAction: TextInputAction.next,
      validator: (cfu) {
        if (cfu.isEmpty) return AppLocalizations.of(context).translate('inv_e_cfu');
        int intCfu = int.parse(cfu);
        return (intCfu > 0 && intCfu <= 100) ? null : AppLocalizations.of(context).translate('inv_e_cfu');
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
        Text(AppLocalizations.of(context).translate('alr_taken')),
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
        labelText: AppLocalizations.of(context).translate("exam_mark"),
        hintText: AppLocalizations.of(context).translate("range_marks"),
      ),
      textInputAction: TextInputAction.done,
      validator: (mark) {
        if (!_alreadyTaken) return null;
        if (mark.isEmpty) return AppLocalizations.of(context).translate('inv_mark');
        int intMark = int.parse(mark);
        if (intMark >= 18 && intMark <= 30) {
          if (_cumLaude && intMark != 30) return AppLocalizations.of(context).translate('err_laude');
          return null;
        }
        return AppLocalizations.of(context).translate('inv_mark');
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
    AppLocalizations.of(context).translate('laude') + ":",
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
  ElevatedButton submitButton(
      BuildContext context, Function(Exam) updateShowExamsPageFunction) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor, // background
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if (_alreadyTaken) {
            log('$_examName, $_examCfu, $_examMark, $_cumLaude');
            _observableFromController.notify(AddExamMessage(
                Exam.taken(_examName, _examCfu, _examMark, _cumLaude),
                requestAnotherExam,
                updateAfterAddExam));
          } else {
            log('$_examName, $_examCfu');
            _observableFromController.notify(AddExamMessage(
                Exam(_examName, _examCfu),
                requestAnotherExam,
                updateAfterAddExam));
          }
        }
      },
      child: Text(
    AppLocalizations.of(context).translate("submit"),
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
