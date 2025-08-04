import 'package:payroll_app_opr_test/data/dto/employee/employee_dto.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';

class LogDto extends Log {
  LogDto({
    required super.id,
    required super.employee,
    required super.timeIn,
    required super.timeOut,
  });

  Log toEntity() {
    return Log(
      id: id,
      employee: employee,
      timeIn: timeIn,
      timeOut: timeOut,
    );
  }

  // from json
  factory LogDto.fromJson(Map<String, dynamic> json) {
    return LogDto(
      id: (json['id'] ?? '').toString(),
      employee: EmployeeDto.fromJson(json['employee']),
      timeIn: DateTime.parse(json['time_in']),
      timeOut: DateTime.parse(json['time_out']),
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employee.id,
      'time_in': timeIn.toIso8601String(),
      'time_out': timeOut.toIso8601String(),
    };
  }

  //Without id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      'employee_id': employee.id,
      'time_in': timeIn.toIso8601String(),
      'time_out': timeOut.toIso8601String(),
    };
  }
}
