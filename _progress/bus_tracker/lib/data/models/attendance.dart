class AttendanceRecord {
  final String studentId;
  final String studentName;
  final String busRoute;
  final AttendanceStatus status;
  final DateTime date;

  AttendanceRecord({
    required this.studentId,
    required this.studentName,
    required this.busRoute,
    required this.status,
    required this.date
  });
}

enum AttendanceStatus {
  present,
  absent,
}