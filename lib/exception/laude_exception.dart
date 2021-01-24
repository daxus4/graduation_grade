class LaudeException implements Exception {
  final int mark;

  LaudeException(this.mark);

  String toString() =>
      "Laude must be associated with only with 30, not with " +
      this.mark.toString();
}
