import 'package:bloc/bloc.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';

import 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {

  ExamsCubit() : super(ExamsInitial());

  void setBaseState(List<Exam> list) {
    emit(ExamsStateBase(list));
  }

  void getExams(Message message) {
    emit(ExamsChanged(message));
  }

  void updateWithNewExam(Exam e) {
    emit(ExamAdded(e));
  }

  void requestAnotherExam(String examName, String message) {
    emit(ExamAlreadyPresent(examName, message));
  }

  void updateDeletingExam(String name) {
    emit(ExamDeleted(name));
  }

  void updateTakenExam(Exam e) {
    emit(ExamTaken(e));
  }
}