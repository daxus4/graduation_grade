import 'package:graduation_grade/pattern/command/message/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/mark_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/name_degree_message.dart';


abstract class ControllableByExamMessage {
  void handleAddExamMessage(AddExamMessage m);
  void handleDeleteExamMessage(DeleteExamMessage m);
  void handleMarkExamMessage(MarkExamMessage m);
  void handleNameDegreeMessage(NameDegreeMessage m);
}