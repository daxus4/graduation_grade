/// [Exception] thrown when you want to access to degree name, but this is not
/// present.
class NotPresentDegreeNameException implements Exception {
  /// Constructor.
  NotPresentDegreeNameException();

  String toString() =>
      "You cannot require the degree name if it is not present";
}
