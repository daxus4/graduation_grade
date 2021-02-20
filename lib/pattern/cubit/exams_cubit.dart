import 'package:bloc/bloc.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';

import 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {

  ExamsCubit() : super(ExamsInitial());

  void setBaseState(List<Exam> list) {
    emit(ExamsStateBase(list));
  }

  void updateWithNewExam(Exam e) {
    emit(ExamAdded(e));
  }

  void getExams(ExamMessage examMessage) {
    emit(ExamsChanged(examMessage));
  }

  void requestAnotherExam(String examName, String message) {
    emit(ExamAlreadyPresent(examName, message));
  }

  void updateDeletingExam(String name) {
    emit(ExamDeleted(name));
  }
}