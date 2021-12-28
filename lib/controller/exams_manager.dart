import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/homepage/homepage.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/exams_model.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/name_degree_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/mark_exam_message.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';
import 'package:graduation_grade/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:graduation_grade/show_exams_page/show_exams_page.dart';

/// Class that is the **controller** for a **MVC pattern** for this application.
///
/// It implements [Observer] in order to get notified when an [ExamMessage] is
/// sent and to correctly update the state of the application by checking the
/// content of the message and the current state of the application.
/// It implements also [ControllableByExamMessage] in order to implement a
/// **command pattern**. This is useful to get a cleaner code used for
/// managing the differents type of [ExamMessage].
class ExamsManager implements Observer<ExamMessage>, ControllableByExamMessage {

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

  Future<void> init() async {
    await examDbHelper.initDatabase();

    List<Exam> exams = await ExamRepository.getExamsFromDb();
    exams.forEach((exam) => _model.addExam(exam));

    bool isStoredDegreeName = await isThereDegreeName();
    if(isStoredDegreeName) {
      String name = await SharedPreferencesManager.getDegreeName();
      _model.setDegreeName(name);
    } else {
      _model.setDegreeName("");
    }
  }

  void _updateShowExamsPage(ExamMessage message) {
    _observerOfUpdateFunctions
        .getUpdateFunctions()[ShowExamsPage.routeName](message);
  }

  void _updateHomePage(ExamMessage message) {
    _observerOfUpdateFunctions.getUpdateFunctions()[HomePage.routeName](message,
        _model.getWAvg(), _model.getCfuAcquired(), _model.getExpectedGrade());
  }

  void _updatePassivePage(ExamMessage m) {
    _updateShowExamsPage(m);
    _updateHomePage(m);
  }

  ExamsModel getModel() => _model;

  @override
  void update(ExamMessage message) {
    message.execute(this);
  }

  @override
  void handleAddExamMessage(AddExamMessage m) {
    Exam e = m.getExam();

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
    Exam e = m.getExam();

    _model.deleteExam(e.getName());
    ExamRepository.deleteExam(e);
    _updatePassivePage(m);
    m.getUpdateAfterDeleteExamFunction()(e.getName());
  }

  @override
  void handleMarkExamMessage(MarkExamMessage m) {
    Exam e = m.getExam();

    _model.takeExam(e);
    ExamRepository.updateExam(e);
    _updatePassivePage(m);
    m.getUpdateAfterMarkExamFunction()(e);
  }

  @override
  void handleNameDegreeMessage(NameDegreeMessage m) {
    Exam e = m.getExam();

    _model.setDegreeName(e.getName());
    SharedPreferencesManager.saveDegreeName(e.getName());
  }

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
