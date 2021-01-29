//Class that represent a university exam not already taken
//For taken exam use decorator

import 'package:graduation_grade/exam/exam.dart';

import '../global_data.dart';

class ExamBase extends Exam {
  final String _name;
  final int _cfu;

  ExamBase(this._name, this._cfu);

  //Constructor that create an ExamBase from a Map
  ExamBase.fromMapObject(Map<String, dynamic> examMap)
      : this(examMap[GlobalData.examNameAttribute],
            examMap[GlobalData.examCfuAttribute]);

  @override
  String getName() {
    return _name.toString();
  }

  @override
  int getCfu() {
    return _cfu;
  }

  Map<String, dynamic> toMap() {
    return {
      GlobalData.examNameAttribute: _name,
      GlobalData.examCfuAttribute: _cfu,
      GlobalData.examMarkAttribute: 0,
      GlobalData.examLaudeAttribute: false,
    };
  }

  @override
  String toString() {
    return 'Exam{name: $_name, cfu: $_cfu}';
  }
}
