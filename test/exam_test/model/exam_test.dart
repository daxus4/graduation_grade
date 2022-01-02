import 'package:graduation_grade/exception/exam_not_taken_exception.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/general_data/global_data.dart';
import 'package:test/test.dart';

void main() {
  group('Exam creation', () {
    String _name = "ml";
    int _cfu = 6;

    test('Constructor for an Exam not taken', () {
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

      Exam e2 = Exam(_name, _cfu);
      expect(e2 == e, true);
    });

    test('Constructor for an Exam with evaluation', () {
      int _mark = 28;
      bool _laude = false;

      Exam e = Exam.taken(_name, _cfu, _mark, _laude);

      expect(e.getName(), _name);
      expect(e.getCfu(), _cfu);
      expect(e.isTaken(), true);
      expect(e.getMark(), _mark);
      expect(e.getLaude(), _laude);

      var eMap = {
        GlobalData.examNameAttribute: _name,
        GlobalData.examCfuAttribute: _cfu,
        GlobalData.examMarkAttribute: _mark,
        GlobalData.examLaudeAttribute: 0,
      };
      expect(e.toMap(), eMap);

      String toStr =
          'Exam{name: $_name, cfu: $_cfu, mark: $_mark, laude: $_laude}';
      expect(e.toString(), toStr);

      expect(() => Exam.taken(_name, _cfu, 17, false),
          throwsA(isA<MarkException>()));
      expect(() => Exam.taken(_name, _cfu, 19, true),
          throwsA(isA<LaudeException>()));

      Exam e2 = Exam.taken(_name, _cfu, _mark, _laude);
      expect(e2 == e, true);
    });

    test('Copy method', () {
      int _mark = 28;
      bool _laude = false;

      Exam e = Exam(_name, _cfu);
      Exam et = Exam.taken(_name, _cfu, _mark, _laude);

      expect(e.copy() == e, true);
      expect(et.copy() == et, true);
    });
  });
}