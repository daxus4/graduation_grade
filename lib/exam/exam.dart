//Class that represent a university exam

class Exam {

  final String name;
  final int cfu;

  Exam(this.name, this.cfu);

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'cfu' : cfu,
      'mark' : 0,
      'cumLaude' : false,
    };
  }

  Exam.fromMapObject(Map<String, dynamic> examMap) :
      name = examMap['name'],
      cfu = examMap['cfu'];

  @override
  String toString() {
    return 'Exam{name: $name, cfu: $cfu}';
  }

}