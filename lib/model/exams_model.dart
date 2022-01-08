import 'package:graduation_grade/exception/already_present_exam_exception.dart';
import 'package:graduation_grade/exception/not_present_degree_name_exception.dart';

import 'exam.dart';

/// Class that represent the **model** for the **MVC pattern**. It contains the
/// current state of the application, which is composed by the [Exam] instances
/// and the degree name.
class ExamsModel {
  final List<Exam> _exams;

  String _degreeName;
  bool _isThereDegreeName = false;

  /// Constructor that require a [List] of [Exam]. It could be an empty List.
  ExamsModel(this._exams);

  /// Return if there is an [Exam] with this name.
  bool isThereExamNamed(String name) => _exams.any((e) => e.getName() == name);

  /// Add an [Exam] to the current state.
  ///
  /// Throws [AlreadyPresentExamException] if there is already an [Exam] with
  /// the passed name.
  void addExam(Exam exam) {
    if (isThereExamNamed(exam.getName()))
      throw AlreadyPresentExamException(exam.getName());
    _exams.add(exam);
  }

  /// Delete the [Exam] with the passed name from the current state.
  void deleteExam(String name) {
    if (isThereExamNamed(name)) _exams.removeWhere((e) => e.getName() == name);
  }

  /// Return the [Exam] with the passed name.
  Exam getExam(String name) => _exams.firstWhere((e) => e.getName() == name);

  /// Change the [Exam] mark and laude.
  void changeExamEvaluation(Exam examTaken) {
    if (isThereExamNamed(examTaken.getName())) {
      deleteExam(examTaken.getName());
      _exams.add(examTaken);
    }
  }

  /// Return the  average of [Exam] marks weighted by CFU for the exams in the
  /// current state.
  double getWAvg() => _exams.length != 0
      ? _exams
              .where((e) => e.isTaken())
              .fold(0, (t, exam) => t + exam.getCfu() * exam.getMark()) /
          getCfuAcquired()
      : 0;

  /// Return the [List] of [Exam] in the current state.
  List<Exam> getExams() => _exams;

  /// Set the degree name
  void setDegreeName(String name) {
    _isThereDegreeName = true;
    _degreeName = name;
  }

  /// Return the number of CFU for the [Exam] in current state with an
  /// evaluation.
  int getCfuAcquired() => _exams.length != 0
      ? _exams.where((e) => e.isTaken()).fold(0, (t, exam) => t + exam.getCfu())
      : 0;

  /// Return the expected graduation grade by multiply the result of
  /// [getWAvg()].
  int getExpectedGrade() => (getWAvg() * 11 / 3).round();

  /// Return the degree name in current state.
  ///
  /// Throws [NotPresentDegreeNameException] if there is not the degree name in
  /// the current state of the model.
  String getDegreeName() {
    if(!_isThereDegreeName)
      throw NotPresentDegreeNameException();
    return _degreeName;
  }

  /// Return if there is the degree name in the current state of the model.
  bool get isThereDegreeName => _isThereDegreeName;
}
