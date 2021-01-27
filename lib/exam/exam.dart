//Class that represent a university exam

class Exam {
  final String name;
  final int cfu;

  Exam(this.name, this.cfu);

  Exam.fromMapObject(Map<String, dynamic> examMap)
      : this(examMap['name'], examMap['cfu']);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cfu': cfu,
      'mark': 0,
      'cumLaude': false,
    };
  }

  @override
  String toString() {
    return 'Exam{name: $name, cfu: $cfu}';
  }
}
