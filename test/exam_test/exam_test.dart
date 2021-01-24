//Test of Exam class

import 'package:test/test.dart';
import 'package:graduation_grade/exam/exam.dart';

final examName = "Math";
final examCfu = 10;
final examMark = 27;
final cumLaude = true;

void main() {
  test("Ensure Exam constructor work", () {
    var exam = Exam(examName, examCfu);
    expect(exam.name, examName);
    expect(exam.cfu, examCfu);
  });
}