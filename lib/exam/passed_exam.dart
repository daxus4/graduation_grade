
import 'package:graduation_grade/exam/exam.dart';

class PassedExam extends Exam {

  final int mark;
  final bool cumLaude;

  PassedExam(String name, int cfu, this.mark, this.cumLaude) : super(name, cfu);

}