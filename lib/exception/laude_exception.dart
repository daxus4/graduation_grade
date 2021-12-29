/// [Exception] thrown when you want to set the laude of an [Exam] whose mark is
/// not 30.
class LaudeException implements Exception {

  /// Mark of the [Exam].
  final int mark;

  /// Constructor that requires the mark of the [Exam].
  LaudeException(this.mark);

  String toString() =>
      "Laude must be associated with only with 30, not with " +
      this.mark.toString();
}
