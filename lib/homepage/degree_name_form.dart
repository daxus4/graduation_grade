import 'package:flutter/material.dart';

class DegreeNameForm extends StatefulWidget {

  final Function(String) _updateName;

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
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
