/// [Exception] thrown when you want to add an [Exam] whose name is
/// already present.
class AlreadyPresentExamException implements Exception {

  /// [Exam] name.
  final String name;

  /// Constructor that requires the name of the [Exam].
  AlreadyPresentExamException(this.name);

  String toString() =>
      "Exam named " + name +" is already present";
}