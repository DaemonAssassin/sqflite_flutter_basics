// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'models/student.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DBHelper _helper = DBHelper();

  @override
  void dispose() {
    _helper.closeDatabase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  print(await _helper
                      .insertStudent(Student(rollNo: 1, name: "Mateen")));
                },
                child: const Text("Insert"),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(await _helper
                      .updateStudent(Student(rollNo: 1, name: "Mubeen")));
                },
                child: const Text("Update"),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(await _helper.deleteStudent(1));
                },
                child: const Text("Delete"),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(await _helper.getStudents());
                },
                child: const Text("Show"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
