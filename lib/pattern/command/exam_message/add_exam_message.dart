import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

class AddExamMessage extends ExamMessage {
  final Function(String) _requestAnotherExamFunction;
  final Function(Exam) _updateAfterAddExamFunction;

  AddExamMessage(Exam exam, this._requestAnotherExamFunction,
      this._updateAfterAddExamFunction)
      : super(exam);

  Function(String) getRequestAnotherExamFunction() =>
      _requestAnotherExamFunction;

  Function(Exam) getUpdateAfterAddExamFunction() => _updateAfterAddExamFunction;

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleAddExamMessage(this);
  }

  @override
  bool operator ==(Object other) {
    return super == other &&
        other is AddExamMessage &&
        _requestAnotherExamFunction == other._requestAnotherExamFunction &&
        _updateAfterAddExamFunction == other._updateAfterAddExamFunction;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
