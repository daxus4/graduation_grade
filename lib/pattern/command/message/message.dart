import '../controllable_by_exam_message.dart';

/// Abstract class that represent the object contained in the notification from
/// [Observable] to [Observer] in the **MVC pattern**. Its subclasses specify
/// the type of notification that have to be sent.
abstract class Message {

  /// This function tell to a [ControllableByExamMessage] which code execute,
  /// in order to get a clean code. This is the main part of the implemented
  /// **command pattern**.
  execute(ControllableByExamMessage controllable);
}