import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username,_email,_password= "";
  final _formKey = GlobalKey<FormState>();

  FocusNode _usernameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Validation"),),
      body: HomePageBody(),
    );
  }

  Widget HomePageBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            NameInput(),
            SizedBox(height: 16,),
            EmailInput(),
            SizedBox(height: 16,),
            PasswordInput(),
            SizedBox(height: 16,),
            SubmitButton()
          ],
        ),
      ),
    );
  }

  Widget NameInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text ,
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "e.g Morgan",
      ),
      textInputAction: TextInputAction.next,
      validator: (name){
        Pattern pattern =
            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;

      },
      onSaved: (name)=> _username = name,
      focusNode: _usernameFocusNode,
      autofocus: true,
      onFieldSubmitted: (_){
        fieldFocusChange(context, _usernameFocusNode, _emailFocusNode);
      },
    );
  }

  Widget EmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress ,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "e.g abc@gmail.com",
      ),
      textInputAction: TextInputAction.next,
      validator: (email)=> email.length!=0 ? null:"Invalid email address",
      onSaved: (email)=> _email = email,
      focusNode: _emailFocusNode,
      onFieldSubmitted: (_){
        fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
      },
    );
  }

  Widget PasswordInput() {
    return TextFormField(
      keyboardType: TextInputType.text ,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: Icon(Icons.lock),
      ),
      textInputAction: TextInputAction.done,
      validator: (password){
        Pattern pattern =
            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(password))
          return 'Invalid password';
        else
          return null;
      },
      onSaved: (password)=> _password = password,
      focusNode: _passwordFocusNode,
    );
  }

  RaisedButton SubmitButton(){
    return  RaisedButton(
      color:Theme.of(context).primaryColor,
      onPressed: (){
        if(_formKey.currentState.validate()){
          _formKey.currentState.save();
          log('$_username, $_email, $_password');
        }
      },
      child: Text("Submit",style: TextStyle(color: Colors.white),),
    );
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}