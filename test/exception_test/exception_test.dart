import 'package:graduation_grade/exception/already_present_exam_exception.dart';
import 'package:graduation_grade/exception/exam_not_taken_exception.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';
import 'package:graduation_grade/exception/not_present_degree_name_exception.dart';
import 'package:test/test.dart';

import 'exception_thrower.dart';

void main() {
  group('Exception tests', () {
    test('AlreadyPresentExamException', () {
      String name = "ml";
      expect(
          () => ExceptionThrower.throwAlreadyPresentExamException(name),
          throwsA(isA<AlreadyPresentExamException>()
              .having((error) => error.name, "name", name)
              .having((error) => error.toString(), "message",
                  "Exam named " + name + " is already present")));
    });

    test('ExamNotTakenException', () {
      expect(
          () => ExceptionThrower.throwExamNotTakenException(),
          throwsA(isA<ExamNotTakenException>().having(
              (error) => error.toString(),
              "message",
              "You cannot require mark or laude in an exam not taken")));
    });

    test('LaudeException', () {
      int mark = 18;
      expect(
          () => ExceptionThrower.throwLaudeException(mark),
          throwsA(isA<LaudeException>()
              .having((error) => error.mark, "mark", mark)
              .having(
                  (error) => error.toString(),
                  "message",
                  "Laude must be associated with only with 30, not with " +
                      mark.toString())));
    });

    test('MarkException', () {
      int mark = 16;
      expect(
          () => ExceptionThrower.throwMarkException(mark),
          throwsA(isA<MarkException>()
              .having((error) => error.mark, "mark", mark)
              .having((error) => error.toString(), "message",
                  "Mark must be between 18 and 30, not " + mark.toString())));
    });

    test('NotPresentDegreeNameException', () {
      expect(
          () => ExceptionThrower.throwNotPresentDegreeNameException(),
          throwsA(isA<NotPresentDegreeNameException>().having(
              (error) => error.toString(),
              "message",
              "You cannot require the degree name if it is not present")));
    });
  });
}
