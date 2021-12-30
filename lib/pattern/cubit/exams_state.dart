import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';

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
  final Message _message;
  ExamsChanged(this._message);

  Message getExamMessage() {
    return _message;
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is ExamsChanged && _message == other._message;
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

class ExamTaken extends ExamsState {
  final Exam _e;

  ExamTaken(this._e);

  Exam getExam() => _e;

  @override
  bool operator == (o) => o is ExamAdded && _e == o._e;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}