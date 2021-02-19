import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

abstract class ExamMessage {
  final Exam _exam;
  final Function _updateFunction;

  ExamMessage(this._exam, this._updateFunction);

  execute(ControllableByExamMessage controllable);

  Exam getExam() => _exam;

  Function getUpdateFunction() => _updateFunction;
}