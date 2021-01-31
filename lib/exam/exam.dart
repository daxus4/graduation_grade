//Upper level interface for decorator pattern

abstract class Exam {
  String getName();

  int getCfu();

  //Return a map of the exam. The laude is a int 0 or 1 instead of boolean
  Map<String, dynamic> toMap();

  @override
  String toString();
}
