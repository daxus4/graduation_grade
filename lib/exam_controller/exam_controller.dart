import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/exception/already_present_exam_exception.dart';

class ExamController {
  final List<Exam> _exams;

  ExamController(this._exams);

  bool isThere(Exam e) => _exams.contains(e);

  void addExam(Exam e) {
    if (isThere(e))
      throw AlreadyPresentExamException(e.getName());
    _exams.add(e);
  }

  void removeExam(Exam e) {
    if(isThere(e))
      _exams.remove(e);
  }

  void takeExam(Exam e, int mark, bool laude) {
    _exams.remove(e);
    _exams.add(Exam.taken(e.getName(), e.getCfu(), mark, laude));
  }

  void deleteAll() => _exams.clear();

}

