import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/exception/already_present_exam_exception.dart';

class ExamController {
  final List<Exam> _exams;

  ExamController(this._exams);

  bool isThere(Exam e) => _exams.any((exam) => exam.getName() == e.getName());

  void addExam(Exam e) {
    if (isThere(e))
      throw AlreadyPresentExamException(e.getName());
    _exams.add(e);
  }

}

