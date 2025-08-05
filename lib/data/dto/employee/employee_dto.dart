import 'package:payroll_app_opr_test/domain/entities/employee.dart';

class EmployeeDto extends Employee {
  EmployeeDto({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.position,
    required super.hourlyRate,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      id: (json['id'] ?? 0).toString(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      position: json['position'] as String,
      hourlyRate: (json['hourly_rate'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'position': position,
      'hourly_rate': hourlyRate,
    };
  }

  //TOJson no id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'position': position,
      'hourly_rate': hourlyRate,
    };
  }

  Employee toEntity() {
    return Employee(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      position: position,
      hourlyRate: hourlyRate,
    );
  }
}
