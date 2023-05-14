

import '../../../data/model/model.dart';

abstract class StudentState {
  List<StudentModel> studentList = [];

  /* //abstract definition of get funnction that will be defined in respective states

  List<StudentModel> get listdata => []; */
  //get might not be needed as by super we are updating data

  StudentState({required this.studentList});
}

class StudentInitialState extends StudentState {
  StudentInitialState() : super(studentList: []);
}

class LoadingState extends StudentState {
  LoadingState(List<StudentModel> studentlist)
      : super(studentList: studentlist);

 /*  @override
  List<StudentModel> get listdata => studentList; */
  
}

class StudentAddState extends StudentState {
  StudentAddState(List<StudentModel> studentlist)
      : super(studentList: studentlist);
}

class StudentViewState extends StudentState {
  StudentViewState(List<StudentModel> studentlist)
      : super(studentList: studentlist);
}


//in search we will be getting searchout list passed here.
class StudentSearchState extends StudentState {
  StudentSearchState(List<StudentModel> studentlist)
      : super(studentList: studentlist);
}
