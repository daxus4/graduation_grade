import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

class NameDegreeMessage extends ExamMessage {
  NameDegreeMessage(Exam exam) : super(exam);

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleNameDegreeMessage(this);
  }

}