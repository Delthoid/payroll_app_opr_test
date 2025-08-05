import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/employee/employee_dto.dart';
import 'package:payroll_app_opr_test/data/dto/log/log_dto.dart';
import 'package:payroll_app_opr_test/data/services/sql_service.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';
import 'package:sqflite/sqflite.dart';

class LogsService {
  final SqlService _sqlService;

  LogsService(this._sqlService);

  Future<ApiResponse<Log>> insertLog({required LogDto log}) async {
    try {
      final db = await _sqlService.database;
      await db.insert(
        'logs',
        log.toJsonWithoutId(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return ApiResponse(
        data: log.toEntity(),
        success: true,
        message: 'Log inserted successfully',
      );
    } catch (e) {
      return ApiResponse(
        data: Log.empty(),
        success: false,
        message: 'Failed to insert log: $e',
      );
    }
  }

  //TODO: Include the employee info here
  Future<ApiResponse<Log>> getById(String id) async {
    final db = await _sqlService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'logs',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final logMap = maps.first;

      final List<Map<String, dynamic>> employeeMaps = await db.query(
        'employees',
        where: 'id = ?',
        whereArgs: [logMap['employee_id']],
      );
      final employee = employeeMaps.isNotEmpty
          ? EmployeeDto.fromJson(employeeMaps.first)
          : Employee.empty();

      final log = LogDto(
        id: (logMap['id'] ?? 0).toString(),
        employee: employee,
        timeIn: DateTime.parse(logMap['time_in']),
        timeOut: DateTime.parse(logMap['time_out']),
      ).toEntity();

      return ApiResponse(
        data: log,
        success: true,
        message: 'Log retrieved successfully',
      );
    } else {
      return ApiResponse(
        data: Log.empty(),
        success: false,
        message: 'Log not found',
      );
    }
  }

  Future<ApiResponse<List<Log>>> getLogs() async {
    final db = await _sqlService.database;
    final List<Map<String, dynamic>> maps = await db.query('logs');

    final List<Log> result = [];
    for (final map in maps) {
      // Fetch employee by employee_id from the logs table
      final List<Map<String, dynamic>> employeeMaps = await db.query(
        'employees',
        where: 'id = ?',
        whereArgs: [map['employee_id']],
        orderBy: 'id DESC',
      );
      final employee = employeeMaps.isNotEmpty
          ? EmployeeDto.fromJson(employeeMaps.first)
          : Employee.empty();

      final log = LogDto(
        id: (map['id'] ?? 0).toString(),
        employee: employee,
        timeIn: DateTime.parse(map['time_in']),
        timeOut: DateTime.parse(map['time_out']),
      ).toEntity();

      result.add(log);
    }

    result.sort((a, b) => (int.tryParse(b.id) ?? 0).compareTo(int.tryParse(a.id) ?? 0));

    return ApiResponse(
      data: result,
      success: true,
      message: 'Logs retrieved successfully',
    );
  }

  Future<ApiResponse<Log>> deleteLog({required String logId}) async {
    final db = await _sqlService.database;
    await db.delete('logs', where: 'id = ?', whereArgs: [logId]);
    return ApiResponse(
      data: Log.empty(),
      success: true,
      message: 'Log deleted successfully',
    );
  }

  Future<ApiResponse<Log>> updateLog({required LogDto log}) async {
    final db = await _sqlService.database;
    await db.update('logs', log.toJson(), where: 'id = ?', whereArgs: [log.id]);
    final updatedLog = await getById(log.id);
    return updatedLog;
  }
}
