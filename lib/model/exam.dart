//Upper level interface for decorator pattern

import 'package:graduation_grade/exception/exam_not_taken_exception.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';

import 'general_data/global_data.dart';


class Exam{
  final String _name;
  final int _cfu;
  bool _isTaken;
  int _mark;
  bool _cumLaude;

  Exam(this._name, this._cfu) {
    _isTaken = false;
  }
  Exam.taken(this._name, this._cfu, this._mark, this._cumLaude) {
    if (this._mark < 18 || this._mark > 30) throw MarkException(_mark);
    if (this._cumLaude && _mark != 30) throw LaudeException(_mark);
    _isTaken = true;
  }

  Exam copy(){
    if(this._isTaken)
      return Exam.taken(this._name, this._cfu, this. _mark, this._cumLaude);
    return Exam(this._name, this._cfu);
  }

  //Constructor that create an ExamBase from a Map
  Exam.fromMapObject(Map<String, dynamic> examMap)
      : this(examMap[GlobalData.examNameAttribute],
      examMap[GlobalData.examCfuAttribute]);

  String getName() {
    return _name.toString();
  }

  int getCfu() {
    return _cfu;
  }

  bool isTaken() => _isTaken;

  int getMark() {
    if(!_isTaken)
      throw ExamNotTakenException();
    return _mark;
  }

  bool getLaude() {
    if(!_isTaken)
      throw ExamNotTakenException();
    return _cumLaude;
  }

  Map<String, dynamic> toMap() {
    if(_isTaken)
      return {
        GlobalData.examNameAttribute: _name,
        GlobalData.examCfuAttribute: _cfu,
        GlobalData.examMarkAttribute: _mark,
        GlobalData.examLaudeAttribute: _cumLaude ? 1:0,
      };
    return {
      GlobalData.examNameAttribute: _name,
      GlobalData.examCfuAttribute: _cfu,
      GlobalData.examMarkAttribute: 0,
      GlobalData.examLaudeAttribute: 0,
    };
  }

  @override
  String toString() {
    if(_isTaken)
      return 'Exam{name: $_name, cfu: $_cfu, mark: $_mark, laude: $_cumLaude}';
    return 'Exam{name: $_name, cfu: $_cfu}';
  }

  @override
  bool operator == (o) {
    if(!o._isTaken)
      return o is Exam && o._name == this._name &&
        o._cfu == this._cfu && o._isTaken == this._isTaken;
    return o is Exam && o._name == this._name &&
        o._cfu == this._cfu && o._isTaken == this._isTaken
        && o._mark == this._mark && o._cumLaude == this._cumLaude;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + _name.hashCode;
    result = 37 * result + _cfu.hashCode;
    result = 37 * result + _mark.hashCode;
    result = 37 * result + _cumLaude.hashCode;
    return result;
  }

}