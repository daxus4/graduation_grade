import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';

/// Abstract class that represent the object contained in the notification from
/// [Observable] to [Observer] in the **MVC pattern**. It contain an [Exam] and
/// its subclasses specify the type of notification that have to be sent.
abstract class ExamMessage extends Message {
  final Exam exam;

  /// Constructor that require a [Exam].
  ExamMessage(this.exam);

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is ExamMessage && exam == other.exam;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;


}