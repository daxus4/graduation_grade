/// Class where are stored all information of the application that should be
/// global.
class GlobalData {
  /// Name of the application.
  static final appName = "Graduation Grade";

  /// Name of the database where information about [Exam] instances are stored.
  static final dbName = 'graduation_grade_db';

  /// Name of the table, in [dbName], where information about [Exam] instances
  /// are stored.
  static final examTableName = 'exam_table';

  /// [String] used as key to indicate an [Exam] name in a [Map] or in a
  /// [Database].
  static final examNameAttribute = 'exam';

  /// [String] used as key to indicate an [Exam] CFU in a [Map] or in a
  /// [Database].
  static final examCfuAttribute = 'cfu';

  /// [String] used as key to indicate an [Exam] mark in a [Map] or in a
  /// [Database].
  static final examMarkAttribute = 'mark';

  /// [String] used as key to indicate an [Exam] laude in a [Map] or in a
  /// [Database].
  static final examLaudeAttribute = 'cumLaude';
}
