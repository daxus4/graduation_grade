import 'dart:ui';

import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';

/// Abstract class that represent the skeleton for the states emitted by
/// [ExamsCubit] in order to update the view when [ExamsModel] is modified.
abstract class ExamsState {
  ExamsState();
}

/// Initial state, assigned to a page when it is created.
class ExamsInitial extends ExamsState {
  ExamsInitial();
}

/// State emitted when there is a change in [ExamsModel].
class ExamsChanged extends ExamsState {
  final Message _message;
  ExamsChanged(this._message);

  Message getExamMessage() => _message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamsChanged && _message == other._message;
  }

  @override
  int get hashCode => _message.hashCode;
}

/// State emitted when the user want to add an [Exam] that is already present in
/// [ExamsModel] current state.
class ExamAlreadyPresent extends ExamsState {
  final String _examName, _message;

  ExamAlreadyPresent(this._examName, this._message);

  String getMessage() => _message;

  @override
  bool operator ==(o) =>
      o is ExamAlreadyPresent &&
      _examName == o._examName &&
      _message == o._message;

  @override
  int get hashCode => hashValues(_examName, _message);
}

/// State added for future purposes, it can be used when there is an undefined
/// error.
class ExamsError extends ExamsState {
  final String message;

  ExamsError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamsError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

/// State emitted when an [Exam] is added to [ExamsModel].
class ExamAdded extends ExamsState {
  final Exam _e;

  ExamAdded(this._e);

  @override
  bool operator ==(o) => o is ExamAdded && _e == o._e;

  @override
  int get hashCode => _e.hashCode;
}

/// State emitted when an [Exam] is deleted from [ExamsModel].
class ExamDeleted extends ExamsState {
  final String _examName;

  ExamDeleted(this._examName);

  @override
  bool operator ==(o) => o is ExamDeleted && _examName == o._examName;

  @override
  int get hashCode => _examName.hashCode;
}

/// State emitted when is added an evaluation to an [Exam] present in
/// [ExamsModel].
class ExamTaken extends ExamsState {
  final Exam _e;

  ExamTaken(this._e);

  Exam getExam() => _e;

  @override
  bool operator ==(o) => o is ExamAdded && _e == o._e;

  @override
  int get hashCode => _e.hashCode;
}
