import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';

class EmployeeDto extends Employee {
  EmployeeDto({
    required super.id,
    required super.name,
    required super.position,
    required super.salary,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      id: json['id'] as String,
      name: json['name'] as String,
      position: json['position'] as String,
      salary: (json['salary'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary,
    };
  }
}
