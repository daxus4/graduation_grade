/// [Exception] thrown when you want to access to information of [Exam] like
/// mark and laude, but the exam does not have an evaluation yet.
class ExamNotTakenException implements Exception {

  /// Constructor.
  ExamNotTakenException();

  String toString() =>
      "You cannot require mark or laude in an exam not taken";
}
