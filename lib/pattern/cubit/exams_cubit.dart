import 'package:bloc/bloc.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';
import 'package:graduation_grade/exam/exam.dart';

import 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {

  ExamsCubit() : super(ExamsInitial());

  void setBaseState(List<Exam> list) {
    emit(ExamsStateBase(list));
  }

  void updateWithNewExam(Exam e) {
    emit(ExamAdded(e));
  }

  Future<void> getExams() async {
    try{
      final exams = await ExamRepository.getExamsFromDb();
      emit(ExamsLoaded(exams));
    } catch (e) {
      emit(ExamsError("Failed to get Exams for local database"));
    }
  }

  void requestAnotherExam(String examName, String message) {
    emit(ExamAlreadyPresent(examName, message));
  }
}