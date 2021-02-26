import 'package:flutter/material.dart';

class ChangeNameDialog extends StatefulWidget {
  final Function(String) _updateName;

  const ChangeNameDialog(this._updateName, {Key key}) : super(key: key);

  @override
  _ChangeNameDialogState createState() => _ChangeNameDialogState(_updateName);
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  final _formKey = GlobalKey<FormState>();

  String _degreeName;

  final Function(String) _updateName;

  _ChangeNameDialogState(this._updateName) : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change name"),
      content: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                degreeNameInput(),
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
        changeButton(context, _updateName),
      ],
    );
  }


  //TextForm in which insert the exam mark
  Widget degreeNameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Degree name",
        hintText: "computer engineering",
      ),
      textInputAction: TextInputAction.done,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        return !regex.hasMatch(name) ? 'Invalid degree name' : null;
      },
      onSaved: (name) => _degreeName = name,
      autofocus: true,
    );
  }

  //Button that insert in the database the data typed by user
  TextButton changeButton(BuildContext context, Function(String) updateName) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _updateName(_degreeName);
          Navigator.pop(context);
        }
      },
      child: Text(
        "Change name",
      ),
    );
  }
}