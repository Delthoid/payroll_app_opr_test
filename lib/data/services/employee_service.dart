import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/employee/employee_dto.dart';
import 'package:payroll_app_opr_test/data/services/sql_service.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class EmployeeService {
  final SqlService _sqlService;

  EmployeeService(this._sqlService);

  Future<ApiResponse<Employee>> addEmployee(EmployeeDto employee) async {
    try {
      final db = await _sqlService.database;
      await db.insert(
        'employees',
        employee.toJsonWithoutId(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return ApiResponse(
        data: employee,
        message: 'Employee added successfully',
      );
    } catch (e) {
      return ApiResponse(
        error: 'Database error',
        success: false,
        message: 'Error adding employee: $e',
      );
    }
  }
}
