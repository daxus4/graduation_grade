import 'package:graduation_grade/exam/exam.dart';
import 'package:graduation_grade/pattern/command/controllable_by_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/add_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/delete_exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/exam_message.dart';
import 'package:graduation_grade/pattern/command/exam_message/take_exam_message.dart';
import 'package:graduation_grade/pattern/cubit/exams_cubit.dart';
import 'package:graduation_grade/pattern/observable/observer.dart';

class ExamController implements Observer<ExamMessage>, ControllableByExamMessage{
  final List<Exam> _exams;
  final ExamsCubit _cubit;

  ExamController(this._exams, this._cubit);

  @override
  void handleAddExamMessage(AddExamMessage m) {
    Exam e = m.getExam();
    if(_exams.any((exam) => exam.getName() == e.getName())) {
      _cubit.requestAnotherExam(e.getName(),
          "Exam named ${e.getName()} is already present");
      return;
    }
    _exams.add(e);
    _cubit.updateWithNewExam(e);
    _cubit.setBaseState(_exams);
  }

  @override
  void handleDeleteExamMessage(DeleteExamMessage m) {
    Exam e = m.getExam();
    if(!_exams.any((exam) => exam.getName() == e.getName()))
      print("eccezione");
    _exams.remove(e);
    print("Aggiorna");
  }

  @override
  void handleTakeExamMessage(TakeExamMessage m) {
    Exam e = m.getExam();
    if( _exams.where((exam) => e.getName() == exam.getName())
        .any((exam) => exam.isTaken()) )
      print("eccezione esame gia dato");
    if( _exams.where((exam) => e.getName() == exam.getName()).isEmpty)
      print("eccezione non ce questo esame");
    _exams.removeWhere((exam) => exam.getName() == e.getName());
    _exams.add(e);
    print("Aggiorna");
  }

  @override
  void update(ExamMessage message) => message.execute(this);

  List<Exam> getExams() => _exams;
}

