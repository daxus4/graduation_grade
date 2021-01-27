//Test of PassedExam class

import 'package:graduation_grade/exam/passed_exam.dart';
import 'package:graduation_grade/global_data.dart';
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

  group('Ensure constructor fromMapObject works', () {
    test("Ensure constructor fromMapObject normally works", () {
      var eMap = {
        GlobalData.examNameAttribute: examName,
        GlobalData.examCfuAttribute: examCfu,
        GlobalData.examMarkAttribute: examMark,
        GlobalData.examLaudeAttribute: cumLaude,
      };
      var exam = PassedExam.fromMapObject(eMap);
      expect(exam.name, examName);
      expect(exam.cfu, examCfu);
      expect(exam.mark, examMark);
      expect(exam.cumLaude, cumLaude);
    });

    test("Ensure constructor fromMapObject throw LaudeException", () {
      var eMap = {
        GlobalData.examNameAttribute: examName,
        GlobalData.examCfuAttribute: examCfu,
        GlobalData.examMarkAttribute: 29,
        GlobalData.examLaudeAttribute: true,
      };
      try {
        PassedExam.fromMapObject(eMap);
      } catch (e) {
        expect(e.toString(),
            "Laude must be associated with only with 30, not with 29");
      }
    });

    test("Ensure constructor fromMapObject throw MarkException", () {
      var eMap = {
        GlobalData.examNameAttribute: examName,
        GlobalData.examCfuAttribute: examCfu,
        GlobalData.examMarkAttribute: 31,
        GlobalData.examLaudeAttribute: false,
      };
      try {
        PassedExam.fromMapObject(eMap);
      } catch (e) {
        expect(e.toString(), "Mark must be between 18 and 30, not 31");
      }
    });
  });

  test("Ensure toMap works", () {
    var exam = PassedExam(examName, examCfu, examMark, cumLaude);
    var eMap = exam.toMap();
    expect(eMap[GlobalData.examNameAttribute], examName);
    expect(eMap[GlobalData.examCfuAttribute], examCfu);
    expect(eMap[GlobalData.examMarkAttribute], examMark);
    expect(eMap[GlobalData.examLaudeAttribute], cumLaude);
  });

  test("Ensure toString works", () {
    var exam = PassedExam(examName, examCfu, examMark, cumLaude);
    expect(exam.toString(),
        'Exam{name: $examName, cfu: $examCfu, mark: $examMark, cumLaude: $cumLaude}');
  });
}


