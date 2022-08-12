import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import '../models/student.dart';
import '../utils/database_constants.dart';

class DBHelper {
  // private constructor
  DBHelper._();

  // private members
  static DBHelper? _dbHelper;
  Database? _database;

  // factory constructor to get instance of DBHelper
  factory DBHelper() {
    return _dbHelper ??= DBHelper._();
  }

  // private getter method to get the instance of db.
  Future<Database> _getDatabase() async {
    return _database ??= await _initDatabase();
  }

  // method to initialize/open database
  Future<Database> _initDatabase() async {
    // Get a location using getDatabasesPath
    String databasePath = await getDatabasesPath();
    String dbFilePath =
        path.join(databasePath, StudentDBConstants.databaseName);

    return await openDatabase(
      dbFilePath,
      version: StudentDBConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  // method to create table in database
  FutureOr<void> _onCreate(Database db, int version) {
    db.execute(StudentDBConstants.createTableCommand);
  }

  // method to close the db
  Future<void> closeDatabase() async {
    Database db = await _getDatabase();
    db.close();
  }

  /// METHODS TO PERFORM CRUD OPS
  /// method to insert/add data/student to db
  Future<bool> insertStudent(Student student) async {
    Map<String, Object?> studentMap = student.toMap();
    Database db = await _getDatabase();
    int rowId = await db.insert(
      StudentDBConstants.tableName,
      studentMap,
      // conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rowId > 0;
  }

  /// method to get the data from the db.
  Future<List<Student>> getStudents() async {
    Database db = await _getDatabase();
    List<Map<String, Object?>> studentsMapList =
        await db.rawQuery(StudentDBConstants.selectEverythingQuery);
    return studentsMapList.map((element) => Student.fromMap(element)).toList();
  }

  /// method to delete student/data from db
  Future<bool> deleteStudent(int rollNo) async {
    Database db = await _getDatabase();
    int rowsEffected = await db.delete(
      StudentDBConstants.tableName,
      where: '${StudentDBConstants.colRollNo} = ?',
      whereArgs: [rollNo],
    );
    return rowsEffected > 0;
  }

  /// method to update student/data in db
  Future<bool> updateStudent(Student student) async {
    Database db = await _getDatabase();
    int changes = await db.update(
      StudentDBConstants.tableName,
      student.toMap(),
      where: '${StudentDBConstants.colRollNo} = ?',
      whereArgs: [student.rollNo],
    );
    return changes > 0;
  }
}
