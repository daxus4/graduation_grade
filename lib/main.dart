import 'package:flutter/material.dart';
import 'package:graduation_grade/database_management/db_helper.dart';
import 'file:///C:/Users/Roberto/AndroidStudioProjects/graduation_grade/lib/general_data/design_data.dart';
import 'file:///C:/Users/Roberto/AndroidStudioProjects/graduation_grade/lib/general_data/global_data.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

import 'database_management/exam_repository.dart';
import 'exam/exam.dart';

final examDbHelper = DbHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await examDbHelper.initDatabase();
  List<Exam> _exams = await ExamRepository.getExamsFromDb();
  runApp(MaterialApp(
    title: GlobalData.appName,
    theme: DesignData.lightTheme,
    home:  ShowExamsPage(_exams),
    ),
  );
}
/*
class MainHome extends StatelessWidget {
  final List<Exam> exams;

  MainHome(this.exams, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(
        //  icon: Icon(Icons.menu),
        //  tooltip: 'Navigation menu',
        //  onPressed: null,
        //),
        title: Text(GlobalData.appName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add exam',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExamForm()),
              );
            },
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Container(
        child: ExamListView(exams),
      ),
    );
  }
}*/