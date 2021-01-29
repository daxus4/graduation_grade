//Test of PassedExam class

import 'package:graduation_grade/exam/exam_base.dart';
import 'package:graduation_grade/exam/passed_exam.dart';
import 'package:graduation_grade/global_data.dart';
import 'package:test/test.dart';

final examName = "Math";
final examCfu = 10;
final examMark = 27;
final cumLaude = false;
final examBase = ExamBase(examName, examCfu);

void main() {
  group("Ensure constructor works", () {
    test("Ensure PassedExam constructor normally work", () {
      var exam = PassedExam(examBase, examMark, cumLaude);
      expect(exam.getName(), examName);
      expect(exam.getCfu(), examCfu);
      expect(exam.mark, examMark);
      expect(exam.cumLaude, cumLaude);
    });

    test("Ensure PassedExam constructor throw LaudeException", () {
      try {
        PassedExam(examBase, 29, true);
      } catch (e) {
        expect(e.toString(),
            "Laude must be associated with only with 30, not with 29");
      }
    });

    test("Ensure PassedExam constructor throw MarkException", () {
      try {
        PassedExam(examBase, 31, false);
      } catch (e) {
        expect(e.toString(), "Mark must be between 18 and 30, not 31");
      }
    });
  });


  test("Ensure toMap works", () {
    var exam = PassedExam(examBase, examMark, cumLaude);
    var eMap = exam.toMap();
    expect(eMap[GlobalData.examNameAttribute], examName);
    expect(eMap[GlobalData.examCfuAttribute], examCfu);
    expect(eMap[GlobalData.examMarkAttribute], examMark);
    expect(eMap[GlobalData.examLaudeAttribute], cumLaude);
  });

  test("Ensure toString works", () {
    var exam = PassedExam(examBase, examMark, cumLaude);
    expect(exam.toString(),
        'Exam{name: $examName, cfu: $examCfu, mark: $examMark, cumLaude: $cumLaude}');
  });
}


