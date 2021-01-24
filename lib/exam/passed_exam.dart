
import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';

class PassedExam extends Exam {

  final int mark;
  final bool cumLaude;

  PassedExam(String name, int cfu, this.mark, this.cumLaude) : super(name, cfu) {
    if(this.mark < 18 || this.mark > 30)
      throw MarkException(mark);
    if(this.cumLaude && mark != 30)
      throw LaudeException(mark);
  }

}