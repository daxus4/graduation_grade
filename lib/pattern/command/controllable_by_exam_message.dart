import 'package:graduation_grade/pattern/command/message/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/exam_message/mark_exam_message.dart';
import 'package:graduation_grade/pattern/command/message/name_degree_message.dart';
import 'package:graduation_grade/pattern/observable/observable.dart';

/// Abstract class that represent the controllable part of the **command
/// pattern**. It contains the function to handle the [Message] sent by
/// [Observable].
abstract class ControllableByMessage {
  /// Function that contains what to do when this class receives an
  /// [AddExamMessage].
  void handleAddExamMessage(AddExamMessage m);

  /// Function that contains what to do when this class receives an
  /// [DeleteExamMessage].
  void handleDeleteExamMessage(DeleteExamMessage m);

  /// Function that contains what to do when this class receives an
  /// [MarkExamMessage].
  void handleMarkExamMessage(MarkExamMessage m);

  /// Function that contains what to do when this class receives an
  /// [NameDegreeMessage].
  void handleNameDegreeMessage(NameDegreeMessage m);
}
