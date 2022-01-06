import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';

import 'message.dart';

/// Class that represent the notification that have to be sent to [Observer]
/// when there is a request to set/change the degree name.
class NameDegreeMessage extends Message {
  /// New name of the degree.
  final String name;

  /// Constructor that require the new name of the degree.
  NameDegreeMessage(this.name);

  @override
  execute(ControllableByMessage controllable) =>
      controllable.handleNameDegreeMessage(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NameDegreeMessage && other.name == this.name;
  }

  @override
  int get hashCode => name.hashCode;
}
