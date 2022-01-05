import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/mark_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/name_degree_message.dart';
import 'package:test/test.dart';

import 'controllable_by_message_fake.dart';

void main() {
  group('Messages', () {
    String _name = "ml";
    int _cfu = 6;
    int _mark = 28;
    bool _laude = false;

    Exam _e = Exam.taken(_name, _cfu, _mark, _laude);

    ControllableByMessageFake _fakeControllable = ControllableByMessageFake();

    test('AddExamMessage', () {
      Function(String) _requestFunction = (String name) {
        return "request";
      };
      Function(Exam) _updateFunction = (Exam e) {
        return "update";
      };

      // Standard checks
      AddExamMessage m = AddExamMessage(_e, _requestFunction, _updateFunction);


      expect(m.exam, _e);
      expect(m.getRequestAnotherExamFunction()(""), "request");
      expect(m.getUpdateAfterAddExamFunction()(_e), "update");

      // Command pattern
      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.exam.getName() + "_add");

      // == and hashcode
      AddExamMessage m2 = AddExamMessage(Exam.taken("ml", 6, 28, false),
          _requestFunction, _updateFunction);
      AddExamMessage m3 = AddExamMessage(Exam.taken("get", 6, 28, false),
          _requestFunction, _updateFunction);

      expect(m, m2);
      expect(m != m3, true);
      expect(m.hashCode, m2.hashCode);
      expect(m.hashCode != m3.hashCode, true);
    });

    test('DeleteExamMessage', () {
      Function(String) _updateFunction = (String name) {
        return "update";
      };

      // Standard checks
      DeleteExamMessage m = DeleteExamMessage(_e, _updateFunction);

      expect(m.exam == _e, true);
      expect(m.getUpdateAfterDeleteExamFunction()(""), "update");

      // Command pattern
      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.exam.getName() + "_del");

      // == and hashcode
      DeleteExamMessage m2 = DeleteExamMessage(
          Exam.taken("ml", 6, 28, false), _updateFunction);
      DeleteExamMessage m3 = DeleteExamMessage(
          Exam.taken("get", 6, 28, false), _updateFunction);

      expect(m, m2);
      expect(m != m3, true);
      expect(m.hashCode, m2.hashCode);
      expect(m.hashCode != m3.hashCode, true);
    });

    test('MarkExamMessage', () {
      Function(Exam) _updateFunction = (Exam e) {
        return "update";
      };

      // Standard checks
      MarkExamMessage m = MarkExamMessage(_e, _updateFunction);

      expect(m.exam == _e, true);
      expect(m.getUpdateAfterMarkExamFunction()(_e), "update");

      // Command Pattern
      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.exam.getName() + "_mark");

      // == and hashcode
      MarkExamMessage m2 = MarkExamMessage(
          Exam.taken("ml", 6, 28, false), _updateFunction);
      MarkExamMessage m3 = MarkExamMessage(
          Exam.taken("get", 6, 28, false), _updateFunction);

      expect(m, m2);
      expect(m != m3, true);
      expect(m.hashCode, m2.hashCode);
      expect(m.hashCode != m3.hashCode, true);
    });

    test('NameDegreeMessage', () {

      // Standard checks
      NameDegreeMessage m = NameDegreeMessage(_name);

      expect(m.name, "ml");

      // Command pattern
      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.name + "_name");

      // == and hashcode
      NameDegreeMessage m2 = NameDegreeMessage("ml");
      NameDegreeMessage m3 = NameDegreeMessage("get");

      expect(m, m2);
      expect(m != m3, true);
      expect(m.hashCode, m2.hashCode);
      expect(m.hashCode != m3.hashCode, true);
    });

  });
}