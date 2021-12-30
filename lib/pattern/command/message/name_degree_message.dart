import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

import 'message.dart';

/// Class that represent the notification that have to be sent to [Observer]
/// when there is a request to set/change the degree name.
class NameDegreeMessage extends Message {

  final String name;
  NameDegreeMessage(this.name);

  @override
  execute(ControllableByExamMessage controllable) {
    controllable.handleNameDegreeMessage(this);
  }

}