import 'package:flutter/material.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/controller/exams_manager.dart';

/// The dialog that appear when a user want to change the degree name.
class ChangeNameDialog extends StatefulWidget {
  final Function(String) _updateName;

  /// Constructor that requires the function that updates the name of the degree
  /// and notify it to [ExamsManager].
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
      title: Text(AppLocalizations.of(context).translate("change_name")),
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
          child: Text(AppLocalizations.of(context).translate("cancel")),
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
        labelText: AppLocalizations.of(context).translate("degree_name"),
        hintText:
            AppLocalizations.of(context).translate("computer_engineering"),
      ),
      textInputAction: TextInputAction.done,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        return !regex.hasMatch(name)
            ? AppLocalizations.of(context).translate("inv_degree_name")
            : null;
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
        AppLocalizations.of(context).translate("change_name"),
      ),
    );
  }
}
