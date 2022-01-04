import 'dart:ui';

import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

import 'exam_message.dart';

/// Class that represent the notification that have to be sent to [Observer]
/// when there is a request to add an [Exam] in the model state.
class AddExamMessage extends ExamMessage {
  final Function(String) _requestAnotherExamFunction;
  final Function(Exam) _updateAfterAddExamFunction;

  /// Constructor that require the exam and two [Function], one that has to
  /// specify what to do when there is already an exam with the same name and
  /// the other what to do when the passed exam can be added in the model state.
  AddExamMessage(Exam exam, this._requestAnotherExamFunction,
      this._updateAfterAddExamFunction)
      : super(exam);

  /// Return the function that specify what to do when there is already an exam
  /// with the same name.
  Function(String) getRequestAnotherExamFunction() =>
      _requestAnotherExamFunction;

  /// Return the function that specify what to do when the passed exam can be
  /// added in the model state.
  Function(Exam) getUpdateAfterAddExamFunction() => _updateAfterAddExamFunction;

  @override
  execute(ControllableByMessage controllable) =>
      controllable.handleAddExamMessage(this);

  @override
  bool operator ==(Object other) =>
      super == other &&
        other is AddExamMessage &&
        _requestAnotherExamFunction == other._requestAnotherExamFunction &&
        _updateAfterAddExamFunction == other._updateAfterAddExamFunction;

  @override
  int get hashCode => hashValues(exam, _requestAnotherExamFunction,
      _updateAfterAddExamFunction);
}
