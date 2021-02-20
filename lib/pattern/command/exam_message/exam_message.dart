import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

abstract class ExamMessage {
  final Exam _exam;

  ExamMessage(this._exam);

  execute(ControllableByExamMessage controllable);

  Exam getExam() => _exam;

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is ExamMessage && _exam == other._exam;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;


}