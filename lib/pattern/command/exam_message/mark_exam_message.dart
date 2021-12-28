import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

class MarkExamMessage extends ExamMessage {
  final Function(Exam) _updateAfterMarkExamFunction;

  MarkExamMessage(Exam exam, this._updateAfterMarkExamFunction) : super(exam);

  Function(Exam) getUpdateAfterMarkExamFunction() =>
      _updateAfterMarkExamFunction;

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleMarkExamMessage(this);
  }

  @override
  bool operator ==(Object other) {
    return super == other && other is MarkExamMessage;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
