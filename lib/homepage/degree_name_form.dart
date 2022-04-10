import 'package:flutter/material.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';

/// Form that appears when you start the app and the there is not a degree name
/// saved in [SharedPreferences].
class DegreeNameForm extends StatefulWidget {
  final Function(String) _updateName;

  /// Constructor that requires the function that updates the name of the degree
  /// and notify it to [ExamsManager].
  const DegreeNameForm(this._updateName, {Key key}) : super(key: key);

  @override
  _DegreeNameFormState createState() => _DegreeNameFormState(_updateName);
}

class _DegreeNameFormState extends State<DegreeNameForm> {
  String _degreeName;

  final _formKey = GlobalKey<FormState>();

  final Function(String) _updateName;

  _DegreeNameFormState(this._updateName) : super();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              degreeNameInput(),
              SizedBox(
                height: 16,
              ),
              submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

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
        if(name.endsWith(' '))
          name = name.substring(0, name.length - 1);
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        return !regex.hasMatch(name)
            ? AppLocalizations.of(context).translate('inv_degree_name')
            : null;
      },
      onSaved: (name) => _degreeName = name,
      autofocus: true,
    );
  }

  submitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor, // background
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _updateName(_degreeName);
        }
      },
      child: Text(
        AppLocalizations.of(context).translate("submit"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
