
abstract class StudentEvent {}

class LoadingEvent extends StudentEvent {}

class AddStudentEvent extends StudentEvent {
  String firstname;
  String lastname;
  String age;
  String major;
  String imagepath;

  AddStudentEvent({required this.firstname,required this.lastname,required this.age,required this.major,required this.imagepath});
}

class UpdateStudentEvent extends StudentEvent {
  int index;
  String firstname;
  String lastname;
  String age;
  String major;
  String imagepath;

  UpdateStudentEvent({required this.index,required this.firstname,required this.lastname,required this.age,required this.major,required this.imagepath});
}

class DeleteStudentEvent extends StudentEvent {
  int index;

  DeleteStudentEvent({required this.index});
}

class SearchStudentEvent extends StudentEvent {
  String query;
  SearchStudentEvent({required this.query});
}

class OnSearchClosed extends StudentEvent {}
