import 'package:collection/collection.dart';
import 'package:graduation_grade/exam/exam.dart';

abstract class ExamsState {
  ExamsState();
}

class ExamsInitial extends ExamsState {
  ExamsInitial();
}

class ExamsLoaded extends ExamsState {
  final List<Exam> _exams;
  ExamsLoaded(this._exams);

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