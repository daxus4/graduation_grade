//Class that represent a university exam

import '../global_data.dart';
//TODO pattern decorator
class Exam {
  final String name;
  final int cfu;

  Exam(this.name, this.cfu);

  //Constructor that create an Exam from a Map
  Exam.fromMapObject(Map<String, dynamic> examMap)
      : this(examMap[GlobalData.examNameAttribute],
      examMap[GlobalData.examCfuAttribute]);

  Map<String, dynamic> toMap() {
    return {
      GlobalData.examNameAttribute : name,
      GlobalData.examCfuAttribute : cfu,
      GlobalData.examMarkAttribute : 0,
      GlobalData.examLaudeAttribute : false,
    };
  }

  @override
  String toString() {
    return 'Exam{name: $name, cfu: $cfu}';
  }
}
