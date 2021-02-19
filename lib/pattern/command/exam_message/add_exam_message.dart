import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

class AddExamMessage extends ExamMessage {
  final Function(String) _requestAnotherExamFunction;
  final Function(Exam) _updateAfterAddExamFunction;


  AddExamMessage(Exam exam, Function updateFunction,
      this._requestAnotherExamFunction, this._updateAfterAddExamFunction)
      : super(exam, updateFunction);

  Function(String) getRequestAnotherExamFunction() =>
      _requestAnotherExamFunction;

  Function(Exam) getUpdateAfterAddExamFunction() =>
      _updateAfterAddExamFunction;

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleAddExamMessage(this);
  }
}
