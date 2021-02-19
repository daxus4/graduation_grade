import 'package:graduation_grade/exception/already_present_exam_exception.dart';

import 'exam.dart';


class ExamsModel {
  final List<Exam> _exams;

  ExamsModel(this._exams);

  bool isThereExamNamed(String name) => _exams.any((e) => e.getName() == name);

  void addExam(Exam exam) {
    if(isThereExamNamed(exam.getName()))
      throw AlreadyPresentExamException(exam.getName());
    _exams.add(exam);
  }

  void deleteExam(String name) {
    if(isThereExamNamed(name))
      _exams.removeWhere((e) => e.getName() == name);
  }

  Exam getExam(String name) {
    return _exams.firstWhere((e) => e.getName() == name);
  }

  List<Exam> getExams() => _exams;
}

