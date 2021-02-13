import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

abstract class ExamMessage {
  final Exam _exam;

  ExamMessage(this._exam);

  execute(ControllableByExamMessage controllable);

  Exam getExam() => _exam;
}