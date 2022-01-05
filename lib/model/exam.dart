import 'dart:ui';

import 'package:graduation_grade/exception/exam_not_taken_exception.dart';
import 'package:graduation_grade/exception/laude_exception.dart';
import 'package:graduation_grade/exception/mark_exception.dart';

import 'general_data/global_data.dart';

/// Class that contain the information of an university exam.
class Exam{

  final String _name;
  final int _cfu;
  bool _isTaken;
  int _mark;
  bool _cumLaude;

  /// Constructor for an [Exam] not taken.
  Exam(this._name, this._cfu) {
    _isTaken = false;
  }

  /// Constructor for an [Exam] taken.
  ///
  /// Throws a [MarkException] if the mark passed is not between 18 and 30.
  /// Throws a [LaudeException] if there is a laude with a mark less than 30.
  Exam.taken(this._name, this._cfu, this._mark, this._cumLaude) {
    if (this._mark < 18 || this._mark > 30) throw MarkException(_mark);
    if (this._cumLaude && _mark != 30) throw LaudeException(_mark);
    _isTaken = true;
  }

  /// Return a deep copy of this [Exam].
  Exam copy(){
    if(this._isTaken)
      return Exam.taken(this._name, this._cfu, this. _mark, this._cumLaude);
    return Exam(this._name, this._cfu);
  }

  /// Return the name of this [Exam].
  String getName() => _name.toString();

  /// Return the CFU of this [Exam].
  int getCfu() => _cfu;

  /// Return if this [Exam] is evaluated.
  bool isTaken() => _isTaken;

  /// Return the mark of this [Exam].
  ///
  /// Throws [ExamNotTakenException] if this [Exam] is not evaluated.
  int getMark() {
    if(!_isTaken)
      throw ExamNotTakenException();
    return _mark;
  }

  /// Return if this [Exam] mark have a laude.
  ///
  /// Throws [ExamNotTakenException] if this [Exam] is not evaluated.
  bool getLaude() {
    if(!_isTaken)
      throw ExamNotTakenException();
    return _cumLaude;
  }

  /// Return the information of this [Exam] as a [Map] using keys in
  /// [GlobalData].
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
  int get hashCode =>
      this._isTaken ? hashValues(_name, _cfu, _isTaken, _mark, _cumLaude)
        : hashValues(_name, _cfu, _isTaken);

}