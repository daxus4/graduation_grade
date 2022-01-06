import 'package:graduation_grade/exception/already_present_exam_exception.dart';
import 'package:graduation_grade/exception/exam_not_taken_exception.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';
import 'package:graduation_grade/exception/not_present_degree_name_exception.dart';

class ExceptionThrower {
  static throwAlreadyPresentExamException(String name) =>
      throw AlreadyPresentExamException(name);

  static throwExamNotTakenException() => throw ExamNotTakenException();

  static throwLaudeException(int mark) => throw LaudeException(mark);

  static throwMarkException(int mark) => throw MarkException(mark);

  static throwNotPresentDegreeNameException() =>
      throw NotPresentDegreeNameException();
}
