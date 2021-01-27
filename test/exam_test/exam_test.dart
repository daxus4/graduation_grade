//Test of Exam class

import 'package:graduation_grade/exam/exam.dart';
import 'package:test/test.dart';

final examName = "Math";
final examCfu = 10;

void main() {
  test("Ensure Exam constructor works", () {
    var exam = Exam(examName, examCfu);
    expect(exam.name, examName);
    expect(exam.cfu, examCfu);
  });

  test("Ensure constructor fromMapObject works", () {
    var eMap = {
      'name': examName,
      'cfu': examCfu,
      'mark': 0,
      'cumLaude': false,
    };
    var exam = Exam.fromMapObject(eMap);
    expect(exam.name, examName);
    expect(exam.cfu, examCfu);
  });

  test("Ensure toMap works", () {
    var exam = Exam(examName, examCfu);
    var eMap = exam.toMap();
    expect(eMap['name'], examName);
    expect(eMap['cfu'], examCfu);
    expect(eMap['mark'], 0);
    expect(eMap['cumLaude'], false);
  });

  test("Ensure toString works", () {
    var exam = Exam(examName, examCfu);
    expect(exam.toString(), 'Exam{name: $examName, cfu: $examCfu}');
  });
}
