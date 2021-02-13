import 'exam_message/add_exam_message.dart';
import 'exam_message/delete_exam_message.dart';
import 'exam_message/take_exam_message.dart';

abstract class ControllableByExamMessage {
  void handleAddExamMessage(AddExamMessage m);
  void handleDeleteExamMessage(DeleteExamMessage m);
  void handleTakeExamMessage(TakeExamMessage m);
}