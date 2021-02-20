import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

abstract class ExamsState {
  ExamsState();
}

class ExamsInitial extends ExamsState {
  ExamsInitial();
}

class ExamsStateBase extends ExamsState {
  final List<Exam> exams;

  ExamsStateBase(this.exams);

}

class ExamsChanged extends ExamsState {
  final ExamMessage _examMessage;
  ExamsChanged(this._examMessage);

  ExamMessage getExamMessage() {
    return _examMessage;
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is ExamsChanged && _examMessage == other._examMessage;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

class ExamAlreadyPresent extends ExamsState {
  final String _examName, _message;

  ExamAlreadyPresent(this._examName, this._message);

  String getMessage() => _message;

  @override
  bool operator == (o) => o is ExamAlreadyPresent && _examName == o._examName
      && _message == o._message;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}

class ExamsError extends ExamsState {
  final String message;

  ExamsError(this.message);

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is ExamsError && other.message == message;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}

class ExamAdded extends ExamsState {
  final Exam _e;

  ExamAdded(this._e);

  @override
  bool operator == (o) => o is ExamAdded && _e == o._e;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}

class ExamDeleted extends ExamsState {
  final String _examName;

  ExamDeleted(this._examName);

  @override
  bool operator == (o) => o is ExamDeleted && _examName == o._examName;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}

class ExamUpdated extends ExamsState {
  final Exam _e;

  ExamUpdated(this._e);

  Exam getExam() => _e;

  @override
  bool operator == (o) => o is ExamAdded && _e == o._e;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}