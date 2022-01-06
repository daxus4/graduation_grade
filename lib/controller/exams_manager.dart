import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/homepage/homepage.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/exams_model.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';
import 'package:graduation_grade/pattern/command/message/name_degree_message.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';
import 'package:graduation_grade/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pattern/command/message/exam_message/delete_exam_message.dart';
import '../pattern/command/message/exam_message/mark_exam_message.dart';

/// Class that is the **controller** for a **MVC pattern** for this application.
///
/// It implements [Observer] in order to get notified when an [ExamMessage] is
/// sent and to correctly update the state of the application by checking the
/// content of the message and the current state of the application.
/// It implements also [ControllableByMessage] in order to implement a
/// **command pattern**. This is useful to get a cleaner code used for
/// managing the different types of [ExamMessage].
class ExamsManager implements Observer<Message>, ControllableByMessage {
  /// The helper class which allows to create and manage an SQL database that
  /// will contain the information about the [Exam] instances.
  final examDbHelper = DbHelper();

  /// Model of MVC pattern. It contains the information about the [Exam]
  /// instances.
  final ExamsModel _model = ExamsModel([]);

  final _ObserverOfUpdateFunctions _observerOfUpdateFunctions =
      _ObserverOfUpdateFunctions();

  Observer<Map<String, Function>> getObserverOfUpdateFunctions() =>
      _observerOfUpdateFunctions;

  /// Initialize the application state, by retrieve data from SQL database and
  /// [SharedPreferences].
  Future<void> init() async {
    await examDbHelper.initDatabase();

    List<Exam> exams = await ExamRepository.getExamsFromDb();
    exams.forEach((exam) => _model.addExam(exam));

    bool isStoredDegreeName = await isThereDegreeName();
    if (isStoredDegreeName) {
      String name = await SharedPreferencesManager.getDegreeName();
      _model.setDegreeName(name);
    } else {
      _model.setDegreeName("");
    }
  }

  void _updateShowExamsPage(Message message) {
    _observerOfUpdateFunctions
        .getUpdateFunctions()[ShowExamsPage.routeName](message);
  }

  void _updateHomePage(Message message) {
    _observerOfUpdateFunctions.getUpdateFunctions()[HomePage.routeName](message,
        _model.getWAvg(), _model.getCfuAcquired(), _model.getExpectedGrade());
  }

  void _updatePassivePage(Message m) {
    _updateShowExamsPage(m);
    _updateHomePage(m);
  }

  /// Return current [ExamsModel] state.
  ExamsModel getModel() => _model;

  @override
  void update(Message message) {
    message.execute(this);
  }

  @override
  void handleAddExamMessage(AddExamMessage m) {
    Exam e = m.exam;

    if (_model.isThereExamNamed(e.getName())) {
      m.getRequestAnotherExamFunction()(e.getName());
      return;
    }
    _model.addExam(e);
    ExamRepository.addExam(e);
    _updatePassivePage(m);
    m.getUpdateAfterAddExamFunction()(e);
  }

  @override
  void handleDeleteExamMessage(DeleteExamMessage m) {
    Exam e = m.exam;

    _model.deleteExam(e.getName());
    ExamRepository.deleteExam(e);
    _updatePassivePage(m);
    m.getUpdateAfterDeleteExamFunction()(e.getName());
  }

  @override
  void handleMarkExamMessage(MarkExamMessage m) {
    Exam e = m.exam;

    _model.changeExamEvaluation(e);
    ExamRepository.updateExam(e);
    _updatePassivePage(m);
    m.getUpdateAfterMarkExamFunction()(e);
  }

  @override
  void handleNameDegreeMessage(NameDegreeMessage m) {
    _model.setDegreeName(m.name);
    SharedPreferencesManager.saveDegreeName(m.name);
  }

  /// Return if the degree name is stored in [SharedPreferences].
  Future<bool> isThereDegreeName() async {
    return await SharedPreferencesManager.isPresentDegreeName();
  }
}

class _ObserverOfUpdateFunctions implements Observer<Map<String, Function>> {
  Map<String, Function> _updateFunctions = Map<String, Function>();

  @override
  void update(Map<String, Function> message) {
    _updateFunctions.addAll(message);
  }

  Map<String, Function> getUpdateFunctions() => _updateFunctions;
}
