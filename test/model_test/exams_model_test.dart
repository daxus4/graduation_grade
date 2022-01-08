import 'package:graduation_grade/exception/not_present_degree_name_exception.dart';
import 'package:graduation_grade/model/exam.dart';
import 'package:graduation_grade/model/exams_model.dart';
import 'package:test/test.dart';

void main() {
  Exam e1 = Exam("ml", 6);
  Exam e2 = Exam.taken("get", 12, 20, false);

  test("Exams Model Test", () {
    ExamsModel model = ExamsModel([e1, e2]);

    // Ensure behavior when there is not the degree name saved.
    expect(model.isThereDegreeName, false);
    expect(() => model.getDegreeName(),
        throwsA(isA<NotPresentDegreeNameException>()));


  });
}