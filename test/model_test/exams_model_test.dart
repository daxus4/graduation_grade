import 'package:graduation_grade/exception/already_present_exam_exception.dart';
import 'package:graduation_grade/exception/not_present_degree_name_exception.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/exams_model.dart';
import 'package:test/test.dart';

void main() {
  group("ExamsModel", (){
    Exam e1 = Exam("ml", 6);
    Exam e2 = Exam.taken("get", 12, 20, false);
    Exam e3 = Exam.taken("biostatistics", 6, 28, false);

    test("Getter setter and calculations", () {
      ExamsModel model = ExamsModel([e1, e2]);

      // Ensure behavior when there is not the degree name saved.
      expect(model.isThereDegreeName, false);
      expect(() => model.getDegreeName(),
          throwsA(isA<NotPresentDegreeNameException>()));

      // Ensure behavior when there is the degree name saved.
      model.setDegreeName("bioinformatics");
      expect(model.isThereDegreeName, true);
      expect(model.getDegreeName(), "bioinformatics");

      // Check if exams are stored correctly
      expect(model.isThereExamNamed("ml"), true);
      expect(model.isThereExamNamed("get"), true);

      expect(model.getExam("ml"), e1);

      List<Exam> returnedExams = model.getExams();
      expect(returnedExams.length, 2);
      expect([e1, e2].every((e) => returnedExams.contains(e)), true);

      // Check if functions to calculate grade are correct.
      expect(model.getCfuAcquired(), 12);
      expect(model.getWAvg(), 20);
      expect(model.getExpectedGrade(), (20*11/3).round());
    });

    test("Modify exams list", (){
      ExamsModel model = ExamsModel([e1, e2]);

      // Check addExam
      expect(model.isThereExamNamed("biostatistics"), false);

      model.addExam(e3);
      expect(model.isThereExamNamed("biostatistics"), true);
      expect(model.getCfuAcquired(), 18);
      expect(model.getWAvg(), (20*12+28*6)/18);

      List<Exam> returnedExams = model.getExams();
      expect(returnedExams.length, 3);

      expect(
              () => model.addExam(Exam("ml", 3)),
          throwsA(isA<AlreadyPresentExamException>()
              .having((error) => error.name, "name", "ml")
              .having((error) => error.toString(), "message",
              "Exam named ml is already present")));

      // Check delete exam
      model.deleteExam("d");
      expect(returnedExams.length, 3);

      model.deleteExam("ml");
      expect(model.isThereExamNamed("ml"), false);
      returnedExams = model.getExams();
      expect(returnedExams.length, 2);


      // Check change exam evaluation
      model.changeExamEvaluation(Exam("programming", 5));
      returnedExams = model.getExams();
      expect(returnedExams.length, 2);
      expect(model.getCfuAcquired(), 18);
      expect(model.getWAvg(), (20*12+28*6)/18);

      model.changeExamEvaluation(Exam.taken("get", 12, 30, false));
      returnedExams = model.getExams();
      expect(returnedExams.length, 2);
      expect(model.getCfuAcquired(), 18);
      expect(model.getWAvg(), (30*12+28*6)/18);

    });
  });

}