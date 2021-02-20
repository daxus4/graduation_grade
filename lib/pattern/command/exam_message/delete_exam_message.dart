import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

class DeleteExamMessage extends ExamMessage {

  final Function(String) _updateAfterDeleteExamFunction;

  DeleteExamMessage(Exam exam, this._updateAfterDeleteExamFunction) : super(exam);

  Function(String) getUpdateAfterDeleteExamFunction() =>
      _updateAfterDeleteExamFunction;

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleDeleteExamMessage(this);
  }

  @override
  bool operator ==(Object other) {
    return super == other &&
        other is DeleteExamMessage &&
        _updateAfterDeleteExamFunction == other._updateAfterDeleteExamFunction;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}