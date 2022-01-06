import 'dart:ui';

import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

import 'exam_message.dart';

/// Class that represent the notification that have to be sent to [Observer]
/// when there is a request to delete an [Exam] in the model state.
class DeleteExamMessage extends ExamMessage {
  final Function(String) _updateAfterDeleteExamFunction;

  /// Constructor that require the exam and a [Function] that has to specify
  /// what to do when the passed exam can be deleted in the model state.
  DeleteExamMessage(Exam exam, this._updateAfterDeleteExamFunction)
      : super(exam);

  /// Return the function that specify what to do when the passed exam can be
  /// deleted in the model state.
  Function(String) getUpdateAfterDeleteExamFunction() =>
      _updateAfterDeleteExamFunction;

  @override
  execute(ControllableByMessage controllable) =>
      controllable.handleDeleteExamMessage(this);

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is DeleteExamMessage &&
      _updateAfterDeleteExamFunction == other._updateAfterDeleteExamFunction;

  @override
  int get hashCode => hashValues(exam, _updateAfterDeleteExamFunction);
}
