import 'package:graduation_grade/exception/exam_not_taken_exception.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:test/test.dart';

void main() {
  group('Exam creation', () {
    test('Constructor for an Exam not taken', () {

      String _name = "ml";
      int _cfu = 6;

      Exam e = Exam(_name, _cfu);

      expect(e.getName(), _name);
      expect(e.getCfu(), _cfu);
      expect(e.isTaken(), false);

      expect(() => e.getMark(), throwsA(isA<ExamNotTakenException>()));
      expect(() => e.getLaude(), throwsA(isA<ExamNotTakenException>()));

      var eMap = {
        GlobalData.examNameAttribute: _name,
        GlobalData.examCfuAttribute: _cfu,
        GlobalData.examMarkAttribute: 0,
        GlobalData.examLaudeAttribute: 0,
      };
      expect(e.toMap(), eMap);

      String toStr = 'Exam{name: $_name, cfu: $_cfu}';
      expect(e.toString(), toStr);

    });
  });
}