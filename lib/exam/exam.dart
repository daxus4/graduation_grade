//Upper level interface for decorator pattern

abstract class Exam {
  String getName();

  int getCfu();

  Map<String, dynamic> toMap();

  @override
  String toString();
}
