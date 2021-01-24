//Test of PassedExam class

import 'package:graduation_grade/exam/passed_exam.dart';
import 'package:test/test.dart';

final examName = "Math";
final examCfu = 10;
final examMark = 27;
final cumLaude = false;

void main() {
  group("Ensure constructor works", () {
    test("Ensure PassedExam constructor normally work", () {
      var exam = PassedExam(examName, examCfu, examMark, cumLaude);
      expect(exam.name, examName);
      expect(exam.cfu, examCfu);
      expect(exam.mark, examMark);
      expect(exam.cumLaude, cumLaude);
    });

    test("Ensure PassedExam constructor throw LaudeException", () {
      try {
        PassedExam(examName, examCfu, 29, true);
      } catch (e) {
        expect(e.toString(),
            "Laude must be associated with only with 30, not with 29");
      }
    });

    test("Ensure PassedExam constructor throw MarkException", () {
      try {
        PassedExam(examName, examCfu, 31, false);
      } catch (e) {
        expect(e.toString(), "Mark must be between 18 and 30, not 31");
      }
    });
  });
}
