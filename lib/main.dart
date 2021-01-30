import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/design_data.dart';
import 'package:graduation_grade/global_data.dart';

import 'form_exam/exam_form.dart';

final examDbHelper = DbHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await examDbHelper.initDatabase();
  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home:  HomePage(),
  ));
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text(GlobalData.appName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}