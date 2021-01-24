class MarkException implements Exception {
  final int mark;

  MarkException(this.mark);

  String toString() =>
      "Mark must be between 18 and 30, not " +
          this.mark.toString();
}
