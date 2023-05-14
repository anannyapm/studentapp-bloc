import 'package:hive_flutter/adapters.dart';

import '../../data/model/model.dart';

class DatabaseRepo{
  static Box<StudentModel> getOpenedBox() {
  return Hive.box('student_db');
}

static Future<void> addStudent(StudentModel value) async {
  final studentDB = getOpenedBox();
  //add value into hive
  final id = await studentDB.add(value);

  //assign id of value as the the id generated and returned by hive when value is added
  value.id = id;
}

static Future<void> deleteStudent(int id) async {
  final studentDB = getOpenedBox();

  await studentDB.deleteAt(id);
}

static Future<void> updateList(int id, StudentModel value) async {
  final studentDB = getOpenedBox();
  studentDB.putAt(id, value);
}

static Future<List<StudentModel>> searchStudent(String query) async{
  final studentDB = getOpenedBox();
  final studentList = studentDB.values;

  final searchOutput = studentList.where((element) {
    String nameVal = element.firstname + element.lastname;
    return nameVal.toLowerCase().contains(query.toLowerCase().trim());
  });
  return searchOutput.toList();
}

}