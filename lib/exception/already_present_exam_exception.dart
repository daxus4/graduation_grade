class AlreadyPresentExamException implements Exception {
  final String name;

  AlreadyPresentExamException(this.name);

  String toString() =>
      "Exam named " + name +" is already present";
}