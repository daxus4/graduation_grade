import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';

import '../global_data.dart';

class PassedExam extends Exam {
  final int mark;
  final bool cumLaude;

  PassedExam(String name, int cfu, this.mark, this.cumLaude)
      : super(name, cfu) {
    if (this.mark < 18 || this.mark > 30) throw MarkException(mark);
    if (this.cumLaude && mark != 30) throw LaudeException(mark);
  }

  //Constructor that create a PassedExam from a Map
  PassedExam.fromMapObject(Map<String, dynamic> examMap)
      : mark = examMap[GlobalData.examMarkAttribute],
        cumLaude = examMap[GlobalData.examLaudeAttribute],
        super.fromMapObject(examMap) {
    if (this.mark < 18 || this.mark > 30) throw MarkException(mark);
    if (this.cumLaude && mark != 30) throw LaudeException(mark);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      GlobalData.examNameAttribute : name,
      GlobalData.examCfuAttribute : cfu,
      GlobalData.examMarkAttribute : mark,
      GlobalData.examLaudeAttribute : cumLaude,
    };
  }

  @override
  String toString() {
    String s = super.toString();
    return s.substring(0, s.length - 1) + ', mark: $mark, cumLaude: $cumLaude}';
  }
}
