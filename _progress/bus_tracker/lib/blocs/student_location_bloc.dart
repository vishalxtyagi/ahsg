import 'package:bloc/bloc.dart';
import 'package:bus_tracker/data/models/student.dart';
import 'package:bus_tracker/data/repositories/location_repository.dart';

class StudentLocationBloc extends Bloc<StudentLocationEvent, StudentLocationState> {

  final LocationRepository _repo;

  StudentLocationBloc(this._repo) : super(StudentLocationState()) {
    on<LoadStudents>(_onLoadStudents);
  }

  void _onLoadStudents(event, emit) {
    _repo.getStudentLocations().listen((locations) {
      emit(state.copyWith(students: locations));
    });
  }

}

// Events
abstract class StudentLocationEvent {}

class LoadStudents extends StudentLocationEvent {}

// States
class StudentLocationState {
  List<Student> students;

  StudentLocationState({this.students = const []});

  StudentLocationState copyWith({List<Student>? students}) {
    return StudentLocationState(
      students: students ?? this.students,
    );
  }
}