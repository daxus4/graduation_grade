import 'package:bloc/bloc.dart';
import 'package:graduation_grade/homepage/homepage.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';
import 'package:graduation_grade/pattern/cubit/information_state.dart';

/// [Cubit] implementation that allows the use of **cubit pattern** when there
/// are changes in [ExamsModel] that have to be notified to the [HomePage].
class InformationCubit extends Cubit<InformationState> {
  /// Constructor that emits a [InformationInitial] state.
  InformationCubit() : super(InformationInitial());

  /// Called when there is a change in the [Exam] instances present in
  /// [ExamsModel] and [HomePage] have to be updated.
  void updateInformation(
      Message message, double wAvg, int cfuAcquired, int expectedGrade) {
    emit(InformationUpdated(message, wAvg, cfuAcquired, expectedGrade));
  }

  /// Called when there is a change in the degree name present in [ExamsModel].
  void updateNameDegree(String name) {
    emit(InformationNameDegreeUpdated(name));
  }
}
