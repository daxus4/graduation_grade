import 'package:graduation_grade/database_management/db_helper.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/exams_model.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/take_exam_message.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';

class ExamsManager implements Observer<ExamMessage>, ControllableByExamMessage {
  final examDbHelper = DbHelper();
  final ExamsModel _model = ExamsModel([]);

  final _ObserverOfUpdateFunction _observerOfUpdateFunction =
      _ObserverOfUpdateFunction();

  Observer<Function> getObserverOfUpdateFunction() => _observerOfUpdateFunction;

  Future<void> init() async {
    await examDbHelper.initDatabase();
    List<Exam> exams = await ExamRepository.getExamsFromDb();
    exams.forEach((exam) => _model.addExam(exam));
  }

  void _updateShowExamsPage(ExamMessage message) {
    _observerOfUpdateFunction.getUpdateFunction()(message);
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
    _updateShowExamsPage(m);
    m.getUpdateAfterAddExamFunction()(e);
  }

  @override
  void handleDeleteExamMessage(DeleteExamMessage m) {
    Exam e = m.getExam();

    _model.deleteExam(e.getName());
    ExamRepository.deleteExam(e);
    _updateShowExamsPage(m);
    m.getUpdateAfterDeleteExamFunction()(e.getName());
  }

  @override
  void handleTakeExamMessage(TakeExamMessage m) {
    Exam e = m.getExam();

    _model.takeExam(e);
    ExamRepository.updateExam(e);
    _updateShowExamsPage(m);
    m.getUpdateAfterTakeExamFunction()(e);
  }
}

class _ObserverOfUpdateFunction implements Observer<Function> {
  Function _updateFunction;

  @override
  void update(Function message) {
    _updateFunction = message;
  }

  Function getUpdateFunction() => _updateFunction;
}
