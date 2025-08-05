import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/employee/employee_dto.dart';
import 'package:payroll_app_opr_test/data/services/sql_service.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
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

  Future<ApiResponse<Employee?>> getEmployeeById(String id) async {
    try {
      final db = await _sqlService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'employees',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ApiResponse(
          data: EmployeeDto.fromJson(maps.first),
          message: 'Employee retrieved successfully',
        );
      } else {
        return ApiResponse(
          error: 'Employee not found',
          success: false,
          message: 'No employee found with id $id',
        );
      }
    } catch (e) {
      return ApiResponse(
        error: 'Database error',
        success: false,
        message: 'Error retrieving employee: $e',
      );
    }
  }

  Future<ApiResponse<Employee>> deleteEmployee(String id) async {
    try {
      final db = await _sqlService.database;
      final int count = await db.delete(
        'employees',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count > 0) {
        return ApiResponse(
          success: true,  
          message: 'Employee deleted successfully',
        );
      } else {
        return ApiResponse(
          error: 'Employee not found',
          success: false,
          message: 'No employee found with id $id',
        );
      }
    } catch (e) {
      return ApiResponse(
        error: 'Database error',
        success: false,
        message: 'Error deleting employee: $e',
      );
    }
  }

  Future<ApiResponse<Employee>> updateEmployee(EmployeeDto employee) async {
    try {
      final db = await _sqlService.database;
      await db.update(
        'employees',
        employee.toJson(),
        where: 'id = ?',
        whereArgs: [employee.id],
      );
      return ApiResponse(
        data: employee,
        success: true,
        message: 'Employee updated successfully',
      );
    } catch (e) {
      return ApiResponse(
        error: 'Database error',
        success: false,
        message: 'Error updating employee: $e',
      );
    }
  }
}
