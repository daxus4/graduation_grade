import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/mark_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/name_degree_message.dart';

/// Class used only for test of **command pattern**. It implements a dumb
/// interface for [ControllableByMessage].
class ControllableByMessageFake extends ControllableByMessage {

  String _name = "";

  @override
  void handleAddExamMessage(AddExamMessage m) {
    _name = m.exam.getName() + "_add";
  }

  @override
  void handleDeleteExamMessage(DeleteExamMessage m) {
    _name = m.exam.getName() + "_del";
  }

  @override
  void handleMarkExamMessage(MarkExamMessage m) {
    _name = m.exam.getName() + "_mark";
  }

  @override
  void handleNameDegreeMessage(NameDegreeMessage m) {
    _name = m.name + "_name";
  }

  String getNameAndType() => _name;
}