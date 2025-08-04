class Employee {
  final String id;
  final String name;
  final String position;
  final double salary;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.salary,
  });

  @override
  String toString() {
    return 'Employee{id: $id, name: $name, position: $position, salary: $salary}';
  }

  Employee copyWith({
    String? id,
    String? name,
    String? position,
    double? salary,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      salary: salary ?? this.salary,
    );
  }
}