import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/cubit/information_cubit.dart';
import 'package:graduation_grade/pattern/cubit/information_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/';

  final Observer<Map<String, Function>> _examController;

  final double _wAvg;
  final int _cfuAcquired;
  final int _expectedGrade;
  final String _degreeName;

  HomePage(this._examController, this._wAvg, this._cfuAcquired,
      this._expectedGrade, this._degreeName)
      : super();

  @override
  State<StatefulWidget> createState() => new _HomePageState(
      _ObservableUpdateFunction([_examController]),
      _wAvg,
      _cfuAcquired,
      _expectedGrade,
      _degreeName);
}

class _ObservableUpdateFunction extends Observable<Map<String, Function>> {
  _ObservableUpdateFunction(List<Observer<Map<String, Function>>> observers)
      : super(observers);
}

class _HomePageState extends State<HomePage> {
  final _ObservableUpdateFunction _observableFromController;

  double _wAvg;
  int _cfuAcquired;
  int _expectedGrade;
  String _degreeName;

  _HomePageState(this._observableFromController, this._wAvg, this._cfuAcquired,
      this._expectedGrade, this._degreeName)
      : super() {
    _observableFromController
        .notify({HomePage.routeName: updateAfterChangeExam});
  }

  void updateAfterChangeExam(
      ExamMessage message, double wAvg, int cfuAcquired, int expectedGrade) {
    BlocProvider.of<InformationCubit>(this.context)
        .updateInformation(message, wAvg, cfuAcquired, expectedGrade);
  }

  void updateAfterChangeDegreeName(String name) {
    BlocProvider.of<InformationCubit>(this.context).updateNameDegree(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalData.appName),
      ),
      // body is the majority of the screen.
      body: Container(
        child: BlocConsumer<InformationCubit, InformationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Text(_degreeName),
                SizedBox(
                  height: 16,
                ),
                Text("Weighted average : " + _wAvg.toStringAsFixed(2)),
                SizedBox(
                  height: 16,
                ),
                Text("Cfu acquired : " + _cfuAcquired.toString()),
                SizedBox(
                  height: 16,
                ),
                Text(
                    "Expected graduation grade : " + _expectedGrade.toString()),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor, // background
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ShowExamsPage.routeName);
                  },
                  child: Text(
                    "Modify",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
