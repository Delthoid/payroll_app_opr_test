import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';

class EmployeeDto extends Employee {
  EmployeeDto({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.position,
    required super.salary,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      position: json['position'] as String,
      salary: (json['salary'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'position': position,
      'salary': salary,
    };
  }

  //TOJson no id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'position': position,
      'salary': salary,
    };
  }
}
