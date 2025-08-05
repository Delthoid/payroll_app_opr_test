import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/employee/employee_dto.dart';
import 'package:payroll_app_opr_test/data/services/sql_service.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';

class EmployeesService {
  final SqlService _sqlService;

  EmployeesService(this._sqlService);

  Future<ApiResponse<List<Employee>>> getEmployees() async {
    try {
      final db = await _sqlService.database;
      final List<Map<String, dynamic>> maps = await db.query('employees', orderBy: 'id DESC');

      final employees = maps.map((map) => EmployeeDto.fromJson(map)).toList();
      return ApiResponse(
        data: employees,
        success: true,
        message: 'Employees retrieved successfully',
      );
    } catch (e) {
      return ApiResponse(
        error: 'Database error',
        success: false,
        message: 'Error retrieving employees: $e',
      );
    }
  }

  Future<ApiResponse<List<Employee>>> searchEmployees(String query) async {
    try {
      final db = await _sqlService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'employees',
        where: 'first_name LIKE ? OR last_name LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: 'id DESC',
      );

      final employees = maps.map((map) => EmployeeDto.fromJson(map)).toList();
      return ApiResponse(
        data: employees,
        success: true,
        message: 'Employees retrieved successfully',
      );
    } catch (e) {
      return ApiResponse(
        error: 'Database error',
        success: false,
        message: 'Error searching employees: $e',
      );
    }
  }
}