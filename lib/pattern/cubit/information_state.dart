import 'dart:ui';

import 'package:graduation_grade/pattern/command/message/message.dart';

/// Abstract class that represent the skeleton for the states emitted by
/// [InformationCubit] in order to update the [HomePage] when [ExamsModel]
/// is modified.
abstract class InformationState {
  InformationState();
}

/// Initial state, assigned to the [HomePage] when it is created.
class InformationInitial extends InformationState {
  InformationInitial();
}

/// State emitted when there is a change in the [Exam] instances present in
/// [ExamsModel].
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
  int get hashCode => hashValues(message, wAvg, cfuAcquired, expectedGrade);
}

/// State emitted when there is a change in the degree name present in
/// [ExamsModel].
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
  int get hashCode => nameDegree.hashCode;
}
