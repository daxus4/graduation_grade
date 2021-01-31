//Interface for decorator of ExamBase

import 'exam.dart';

abstract class ExamDecorator extends Exam {
  //Exam that i want to be decorated
  final Exam exam;

  ExamDecorator(this.exam);

  @override
  String getName();

  @override
  int getCfu();

  @override
  Map<String, dynamic> toMap() {
    return exam.toMap();
  }

  @override
  String toString() {
    return exam.toString();
  }
}
