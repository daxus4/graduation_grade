import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

class TakeExamMessage extends ExamMessage {
  TakeExamMessage(Exam exam) : super(exam);

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleTakeExamMessage(this);
  }

}