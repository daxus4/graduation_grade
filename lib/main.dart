import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/design_data.dart';
import 'package:graduation_grade/global_data.dart';

import 'database_management/exam_repository.dart';
import 'exam/exam.dart';
import 'exam_list_view/exam_list_view.dart';

final examDbHelper = DbHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await examDbHelper.initDatabase();
  List<Exam> _exams = await ExamRepository.getExamsFromDb();
  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home:  Scaffold(
      appBar: AppBar(title: Text("Input Validation"),),
      body: ExamListView(_exams),
    ),
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