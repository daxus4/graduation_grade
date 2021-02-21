import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

class TakeExamMessage extends ExamMessage {
  final Function(Exam) _updateAfterTakeExamFunction;

  TakeExamMessage(Exam exam, this._updateAfterTakeExamFunction) : super(exam);

  Function(Exam) getUpdateAfterTakeExamFunction() =>
      _updateAfterTakeExamFunction;

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleTakeExamMessage(this);
  }

  @override
  bool operator ==(Object other) {
    return super == other && other is TakeExamMessage;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
