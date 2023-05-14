
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/model/model.dart';
import '../../../database/functions/db_functions.dart';
import 'app_events.dart';
import 'app_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final List<StudentModel> studentData = [];
  //List<StudentModel> get data => studentData;

  StudentBloc() : super(StudentInitialState()) {
    on<LoadingEvent>(
      (event, emit) async {
        debugPrint("Loading");
        final studentDataFromDB = DatabaseRepo.getOpenedBox().values.toList();
        studentData.clear();
        studentData.addAll(studentDataFromDB);
        //emit(StudentInitialState());
        emit(LoadingState(studentData));
      },
    );

    on<AddStudentEvent>(
      (event, emit) async {
        StudentModel studentObject = StudentModel(
            firstname: event.firstname,
            lastname: event.lastname,
            age: event.age,
            major: event.major,
            photo: event.imagepath);
        DatabaseRepo.addStudent(studentObject);
        //since we already have all actions like getting data from db,
        //and updating it into list, we will add loading event to Stream.

        add(LoadingEvent());

        debugPrint("Add student clicked");
      },
    );

    on<UpdateStudentEvent>(
      (event, emit) {
        StudentModel studentObject = StudentModel(
            firstname: event.firstname,
            lastname: event.lastname,
            age: event.age,
            major: event.major,
            photo: event.imagepath);
        DatabaseRepo.updateList(event.index, studentObject);
        add(LoadingEvent());
        debugPrint("Update pressed");
      },
    );

    on<DeleteStudentEvent>(
      (event, emit) {
        DatabaseRepo.deleteStudent(event.index);
        add(LoadingEvent());
        debugPrint("delete pressed");
      },
    );
    on<SearchStudentEvent>(
      (event, emit) async {
        debugPrint("search pressed");

        List<StudentModel> searchOutput =
            await DatabaseRepo.searchStudent(event.query);
        emit(StudentSearchState(searchOutput));
      },
    );

    on<OnSearchClosed>((event, emit) async {
      add(LoadingEvent());
    });
  }
}
