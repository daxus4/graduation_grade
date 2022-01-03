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

      AddExamMessage m = AddExamMessage(_e, _requestFunction, _updateFunction);
      AddExamMessage m2 = AddExamMessage(Exam.taken("ml", 6, 28, false),
          _requestFunction, _updateFunction);


      expect(m.exam == _e, true);
      expect(m.getRequestAnotherExamFunction()(""), "request");
      expect(m.getUpdateAfterAddExamFunction()(_e), "update");

      expect(m == m2, true);

      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.exam.getName() + "_add");
    });

    test('DeleteExamMessage', () {
      Function(String) _updateFunction = (String name) {
        return "update";
      };

      DeleteExamMessage m = DeleteExamMessage(_e, _updateFunction);
      DeleteExamMessage m2 = DeleteExamMessage(
          Exam.taken("ml", 6, 28, false), _updateFunction);


      expect(m.exam == _e, true);
      expect(m.getUpdateAfterDeleteExamFunction()(""), "update");

      expect(m == m2, true);

      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.exam.getName() + "_del");
    });

    test('MarkExamMessage', () {
      Function(Exam) _updateFunction = (Exam e) {
        return "update";
      };

      MarkExamMessage m = MarkExamMessage(_e, _updateFunction);
      MarkExamMessage m2 = MarkExamMessage(
          Exam.taken("ml", 6, 28, false), _updateFunction);


      expect(m.exam == _e, true);
      expect(m.getUpdateAfterMarkExamFunction()(_e), "update");

      expect(m == m2, true);

      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.exam.getName() + "_mark");
    });

    test('NameDegreeMessage', () {

      NameDegreeMessage m = NameDegreeMessage(_name);
      NameDegreeMessage m2 = NameDegreeMessage("ml");

      expect(m.name, "ml");

      expect(m == m2, true);

      m.execute(_fakeControllable);
      expect(_fakeControllable.getNameAndType(), m.name + "_name");
    });

  });
}