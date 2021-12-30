
import 'package:graduation_grade/pattern/command/message/message.dart';

abstract class InformationState {
  InformationState();
}

class InformationInitial extends InformationState {
  InformationInitial();
}

class InformationUpdated extends InformationState {
  final Message message;
  final double wAvg;
  final int cfuAcquired;
  final int expectedGrade;

  InformationUpdated(
      this.message, this.wAvg, this.cfuAcquired, this.expectedGrade);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InformationUpdated &&
        message == other.message &&
        wAvg == other.wAvg &&
        cfuAcquired == other.cfuAcquired &&
        expectedGrade == other.expectedGrade;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

class InformationNameDegreeUpdated extends InformationState {
  final String nameDegree;

  InformationNameDegreeUpdated(this.nameDegree);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InformationNameDegreeUpdated &&
        nameDegree == other.nameDegree;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}
