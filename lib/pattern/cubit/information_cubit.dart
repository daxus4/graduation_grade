import 'package:bloc/bloc.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/cubit/information_state.dart';

class InformationCubit extends Cubit<InformationState> {
  InformationCubit() : super(InformationInitial());

  void updateInformation(
      ExamMessage message, double wAvg, int cfuAcquired, int expectedGrade) {
    emit(InformationUpdated(message, wAvg, cfuAcquired, expectedGrade));
  }

  void updateNameDegree(String name) {
    emit(InformationNameDegreeUpdated(name));
  }
}
