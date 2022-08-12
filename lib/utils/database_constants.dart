class StudentDBConstants {
  static const String databaseName = 'student.db';
  static const int databaseVersion = 1;
  static const String tableName = 'STUDENT';
  static const String colId = 'id';
  static const String colRollNo = 'roll_no';
  static const String colName = 'name';
  static const String createTableCommand = '''
CREATE TABLE $tableName (
  $colId INTEGER PRIMARY KEY AUTOINCREMENT,
  $colRollNo INTEGER NOT NULL,
  $colName TEXT NOT NULL
)
''';
  static const String selectEverythingQuery = 'SELECT * FROM $tableName';
}
