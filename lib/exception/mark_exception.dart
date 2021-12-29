/// [Exception] thrown when you want to set a mark of an [Exam] that is not
/// between 18 and 30.
class MarkException implements Exception {

  /// Mark of the [Exam].
  final int mark;

  /// Constructor that requires the mark of the [Exam].
  MarkException(this.mark);

  String toString() =>
      "Mark must be between 18 and 30, not " +
          this.mark.toString();
}
