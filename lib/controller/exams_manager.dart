
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/exams_model.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/take_exam_message.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';

class ExamsManager implements Observer<ExamMessage>, ControllableByExamMessage{

  final ExamsModel _model;

  ExamsManager(this._model);

  @override
  void update(ExamMessage message) {
    message.execute(this);
  }

  @override
  void handleAddExamMessage(AddExamMessage m) {
    Exam e = m.getExam();

    if(_model.isThereExamNamed(e.getName())) {
      m.getRequestAnotherExamFunction()(e.getName());
      return;
    }
    _model.addExam(e);
    m.getUpdateFunction()(e);
    m.getUpdateAfterAddExamFunction()(e);

  }

  @override
  void handleDeleteExamMessage(DeleteExamMessage m) {
  }

  @override
  void handleTakeExamMessage(TakeExamMessage m) {
  }

}