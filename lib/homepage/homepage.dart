import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_grade/app_localizations/app_localizations.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';
import 'package:graduation_grade/pattern/command/message/name_degree_message.dart';
import 'package:graduation_grade/pattern/cubit/information_cubit.dart';
import 'package:graduation_grade/pattern/cubit/information_state.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

import 'change_name_dialog.dart';
import 'degree_name_form.dart';

/// Homepage of the application. In this we shown the name of the degree and the
/// information about averages and CFU.
class HomePage extends StatefulWidget {

  /// Homepage route.
  static final routeName = '/';

  final Observer<Map<String, Function>> _examControllerObserverFunction;
  final Observer<Message> _examController;

  final double _wAvg;
  final int _cfuAcquired;
  final int _expectedGrade;
  final String _degreeName;

  /// Constructor that requires an [Observer] of [ExamMessage] in order to
  /// notify it when the degree name is changed and an [Observer] to whom we
  /// will pass the function that it can use to update the state of this
  /// homepage.
  HomePage(this._examController, this._examControllerObserverFunction,
      this._wAvg, this._cfuAcquired, this._expectedGrade, this._degreeName)
      : super();

  @override
  State<StatefulWidget> createState() => new _HomePageState(
      _ObservableExamMessage([_examController]),
      _ObservableUpdateFunction([_examControllerObserverFunction]),
      _wAvg,
      _cfuAcquired,
      _expectedGrade,
      _degreeName);
}

class _ObservableUpdateFunction extends Observable<Map<String, Function>> {
  _ObservableUpdateFunction(List<Observer<Map<String, Function>>> observers)
      : super(observers);
}

class _ObservableExamMessage extends Observable<Message> {
  _ObservableExamMessage(List<Observer<Message>> observers)
      : super(observers);
}

class _HomePageState extends State<HomePage> {
  final _ObservableUpdateFunction _observableFromController;
  final _ObservableExamMessage _examController;

  double _wAvg;
  int _cfuAcquired;
  int _expectedGrade;
  String _degreeName;

  _HomePageState(this._examController, this._observableFromController,
      this._wAvg, this._cfuAcquired, this._expectedGrade, this._degreeName)
      : super() {
    _observableFromController
        .notify({HomePage.routeName: updateAfterChangeExam});
  }

  void updateAfterChangeExam(
      ExamMessage message, double wAvg, int cfuAcquired, int expectedGrade) {
    _wAvg = wAvg;
    _cfuAcquired = cfuAcquired;
    _expectedGrade = expectedGrade;
    BlocProvider.of<InformationCubit>(this.context)
        .updateInformation(message, wAvg, cfuAcquired, expectedGrade);
  }

  void updateAfterChangeDegreeName(String name) {
    _degreeName = name;
    _examController.notify(NameDegreeMessage(name));
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
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<InformationCubit, InformationState>(
          listener: (context, state) {
            if (state is InformationNameDegreeUpdated)
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(GlobalData.appName),
                  content: Text(AppLocalizations.of(context).translate("dgr_nm_upd")),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
          },
          builder: (context, state) {
            if (_degreeName.isEmpty)
              return SingleChildScrollView(
                child: DegreeNameForm(updateAfterChangeDegreeName),
              );
            return SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(_degreeName),
                    modifyNameButton(),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(AppLocalizations.of(context).translate("w_avg") +
                    ": " +
                    _wAvg.toStringAsFixed(2)),
                SizedBox(
                  height: 16,
                ),
                Text(AppLocalizations.of(context).translate("acquired_cfu") +
                    ": " +
                    _cfuAcquired.toString()),
                SizedBox(
                  height: 16,
                ),
                Text(AppLocalizations.of(context).translate("expected_grade") +
                    ": " +
                    _expectedGrade.toString()),
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
                    AppLocalizations.of(context).translate("marks"),
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

  Widget modifyNameButton() {
    return IconButton(
      icon: Icon(Icons.mode_edit),
      tooltip: AppLocalizations.of(context).translate('change_name'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => ChangeNameDialog(updateAfterChangeDegreeName),
        );
      },
    );
  }
}
