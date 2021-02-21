import 'package:flutter/material.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';

class UpdateExamDialog extends StatefulWidget {
  @override
  _UpdateExamDialogState createState() => _UpdateExamDialogState();
}

class _UpdateExamDialogState extends State<UpdateExamDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _cumLaude = false;
  int _examMark;

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
            Navigator.pop(context, Map<String, dynamic>());
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
          Navigator.pop(context, {GlobalData.examMarkAttribute: _examMark,
            GlobalData.examLaudeAttribute: _cumLaude,});
        }
      },
      child: Text(
        "Update",
      ),
    );
  }
}