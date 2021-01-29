//Test of Exam class

import 'package:graduation_grade/exam/exam_base.dart';
import 'package:graduation_grade/global_data.dart';
import 'package:test/test.dart';

final examName = "Math";
final examCfu = 10;

void main() {
  test("Ensure Exam constructor works", () {
    var exam = ExamBase(examName, examCfu);
    expect(exam.getName(), examName);
    expect(exam.getCfu(), examCfu);
  });

  test("Ensure constructor fromMapObject works", () {
    var eMap = {
      GlobalData.examNameAttribute: examName,
      GlobalData.examCfuAttribute: examCfu,
      GlobalData.examMarkAttribute: 0,
      GlobalData.examLaudeAttribute: false,
    };
    var exam = ExamBase.fromMapObject(eMap);
    expect(exam.getName(), examName);
    expect(exam.getCfu(), examCfu);
  });

  test("Ensure toMap works", () {
    var exam = ExamBase(examName, examCfu);
    var eMap = exam.toMap();
    expect(eMap[GlobalData.examNameAttribute], examName);
    expect(eMap[GlobalData.examCfuAttribute], examCfu);
    expect(eMap[GlobalData.examMarkAttribute], 0);
    expect(eMap[GlobalData.examLaudeAttribute], false);
  });

  test("Ensure toString works", () {
    var exam = ExamBase(examName, examCfu);
    expect(exam.toString(), 'Exam{name: $examName, cfu: $examCfu}');
  });
}
