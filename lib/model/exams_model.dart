import 'package:graduation_grade/exception/already_present_exam_exception.dart';

import 'exam.dart';

class ExamsModel {
  final List<Exam> _exams;
  String _degreeName;

  ExamsModel(this._exams);

  bool isThereExamNamed(String name) => _exams.any((e) => e.getName() == name);

  void addExam(Exam exam) {
    if (isThereExamNamed(exam.getName()))
      throw AlreadyPresentExamException(exam.getName());
    _exams.add(exam);
  }

  void deleteExam(String name) {
    if (isThereExamNamed(name)) _exams.removeWhere((e) => e.getName() == name);
  }

  Exam getExam(String name) {
    return _exams.firstWhere((e) => e.getName() == name);
  }

  void takeExam(Exam examTaken) {
    if (isThereExamNamed(examTaken.getName())) {
      deleteExam(examTaken.getName());
      _exams.add(examTaken);
    }
  }

  double getWAvg() {
    return _exams.length != 0 ?_exams
            .where((e) => e.isTaken())
            .fold(0, (t, exam) => t + exam.getCfu() * exam.getMark())
        /
        getCfuAcquired() : 0;
  }

  List<Exam> getExams() => _exams;

  void setDegreeName(String name) {
    _degreeName = name;
  }

  int getCfuAcquired() {
    return _exams.length != 0 ? _exams
        .where((e) => e.isTaken())
        .fold(0, (t, exam) => t + exam.getCfu()) : 0;
  }

  int getExpectedGrade() {
    return (getWAvg() * 11 / 3).round();
  }

  String getDegreeName() => _degreeName;
}
