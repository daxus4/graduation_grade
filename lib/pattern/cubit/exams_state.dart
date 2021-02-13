import 'package:collection/collection.dart';
import 'package:graduation_grade/exam/exam.dart';

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

class ExamsLoaded extends ExamsState {
  final List<Exam> _exams;
  ExamsLoaded(this._exams);

  List<Exam> getExams() {
    return _exams;
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is ExamsLoaded &&
        DeepCollectionEquality().equals(this._exams, other._exams);
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