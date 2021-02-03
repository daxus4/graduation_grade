class ExamNotTakenException implements Exception {

  ExamNotTakenException();

  String toString() =>
      "You cannot require mark o laude in an exam not taken";
}
