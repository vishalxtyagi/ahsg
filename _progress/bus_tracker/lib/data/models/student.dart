class Student {
  final String id;
  final String name;
  final String busRoute;
  bool isPresent;

  Student({
    required this.id,
    required this.name,
    required this.busRoute,
    this.isPresent = false,
  });
}