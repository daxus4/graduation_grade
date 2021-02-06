import 'package:bloc/bloc.dart';
import 'package:graduation_grade/cubit/exams_state.dart';
import 'package:graduation_grade/database_management/exam_repository.dart';

class ExamsCubit extends Cubit<ExamsState> {

  ExamsCubit() : super(ExamsInitial());

  Future<void> getExams() async {
    try{
      final exams = await ExamRepository.getExamsFromDb();
      emit(ExamsLoaded(exams));
    } catch (e) {
      emit(ExamsError("Failed to get Exams for local database"));
    }
  }
}