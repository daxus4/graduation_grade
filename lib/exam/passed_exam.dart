import 'package:graduation_grade/exam/exam_decorator.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';

import '../global_data.dart';
import 'exam.dart';

class PassedExam extends ExamDecorator {
  final int mark;
  final bool cumLaude;

  PassedExam(Exam exam, this.mark, this.cumLaude)
      : super(exam) {
    if (this.mark < 18 || this.mark > 30) throw MarkException(mark);
    if (this.cumLaude && mark != 30) throw LaudeException(mark);
  }

  @override
  int getCfu() {
    return exam.getCfu();
  }

  @override
  String getName() {
    return exam.getName();
  }

  @override
  Map<String, dynamic> toMap() {
    var examMap = exam.toMap();
    examMap.addAll({
      GlobalData.examMarkAttribute: mark,
      GlobalData.examLaudeAttribute: cumLaude,
    });
    return examMap;
  }

  @override
  String toString() {
    String s = super.toString();
    return s.substring(0, s.length - 1) + ', mark: $mark, cumLaude: $cumLaude}';
  }
}
