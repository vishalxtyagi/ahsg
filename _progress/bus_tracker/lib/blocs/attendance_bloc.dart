import 'package:bloc/bloc.dart';
import 'package:bus_tracker/data/models/attendance.dart';
import 'package:bus_tracker/data/repositories/attendance_repository.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {

  final AttendanceRepository _repo;

  AttendanceBloc(this._repo) : super(AttendanceState()) {
    on<LoadAttendance>(_onLoadAttendance);
  }

  void _onLoadAttendance(event, emit) async {
    emit(state.copyWith(status: AttendanceStatus.loading));

    try {
      final records = await _repo.getAttendance();
      emit(state.copyWith(
          status: AttendanceStatus.success,
          records: records
      ));
    } catch (e) {
      emit(state.copyWith(status: AttendanceStatus.failure));
    }
  }

}

// Events
abstract class AttendanceEvent {}

class LoadAttendance extends AttendanceEvent {}

// States
class AttendanceState {
  List<AttendanceRecord> records;
  AttendanceStatus status;

  AttendanceState({
    this.records = const [],
    this.status = AttendanceStatus.initial,
  });

  AttendanceState copyWith({
    List<AttendanceRecord>? records,
    AttendanceStatus? status,
  }) {
    return AttendanceState(
      records: records ?? this.records,
      status: status ?? this.status,
    );
  }
}

enum AttendanceStatus { initial, loading, success, failure }