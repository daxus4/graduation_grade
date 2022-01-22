import 'package:bloc/bloc.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/pattern/command/message/message.dart';

import 'exams_state.dart';

/// [Cubit] implementation that allows the use of **cubit pattern** when there
/// are changes in [ExamsModel] that have to be notified to the view.
class ExamsCubit extends Cubit<ExamsState> {
  ExamsCubit() : super(ExamsInitial());

  /// Called when the page have to be refreshed because there is a change in
  /// [ExamsModel].
  void getExams(Message message) {
    emit(ExamsChanged(message));
  }

  /// Called when the page have to be refreshed because a new [Exam] is added in
  /// [ExamsModel].
  void updateWithNewExam(Exam e) {
    emit(ExamAdded(e));
  }

  /// Called when the user want to add an [Exam] that is already present in
  /// [ExamsModel] current state.
  void requestAnotherExam(String examName, String message) {
    emit(ExamAlreadyPresent(examName, message));
  }

  /// Called when the page have to be refreshed because an [Exam] is deleted
  /// from [ExamsModel].
  void updateDeletingExam(String name) {
    emit(ExamDeleted(name));
  }

  /// Called when the page have to be refreshed because a evaluation is added to
  /// an [Exam] present in [ExamsModel].
  void updateTakenExam(Exam e) {
    emit(ExamTaken(e));
  }
}
