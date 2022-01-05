import 'dart:ui';

import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

import 'exam_message.dart';

/// Class that represent the notification that have to be sent to [Observer]
/// when there is a request to evaluate an [Exam] in the model state.
class MarkExamMessage extends ExamMessage {
  final Function(Exam) _updateAfterMarkExamFunction;

  /// Constructor that require the exam and a [Function] that has to specify
  /// what to do when the passed exam can be evaluated in the model state.
  MarkExamMessage(Exam exam, this._updateAfterMarkExamFunction) : super(exam);

  /// Return the function that specify what to do when the passed exam can be
  /// evaluated in the model state.
  Function(Exam) getUpdateAfterMarkExamFunction() =>
      _updateAfterMarkExamFunction;

  @override
  execute(ControllableByMessage controllable) =>
      controllable.handleMarkExamMessage(this);

  @override
  bool operator ==(Object other) =>
      super == other && other is MarkExamMessage;

  @override
  // TODO: implement hashCode
  int get hashCode => hashValues(exam, _updateAfterMarkExamFunction);
}
