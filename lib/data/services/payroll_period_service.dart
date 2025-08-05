import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/payroll_period.dart';
import 'package:payroll_app_opr_test/data/services/sql_service.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:sqflite/sqflite.dart';

class PayrollPeriodService {
  final SqlService _sqlService;

  PayrollPeriodService(this._sqlService);

  Future<ApiResponse<PayrollPeriod>> createPayrollPeriod({
    required PayrollPeriodDto payrollPeriod,
  }) async {
    try {
      final db = await _sqlService.database;
      await db.insert(
        'payroll_periods',
        payrollPeriod.toJsonWithoutId(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      final latest = await getLatestPayrollPeriod();
      return ApiResponse(
        data: latest.data,
        success: true,
        message: 'Payroll period created successfully',
      );
    } catch (e) {
      return ApiResponse(
        data: PayrollPeriod.empty(),
        success: false,
        message: 'Failed to create payroll period: $e',
      );
    }
  }

  // get latest payroll period
  Future<ApiResponse<PayrollPeriod>> getLatestPayrollPeriod() async {
    try {
      final db = await _sqlService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'payroll_periods',
        orderBy: 'id DESC',
        limit: 1,
      );

      if (maps.isEmpty) {
        return ApiResponse(
          data: PayrollPeriod.empty(),
          success: true,
          message: 'No payroll periods found',
        );
      }

      final payrollPeriod = PayrollPeriodDto.fromJson(maps.first).toEntity();
      return ApiResponse(
        data: payrollPeriod,
        success: true,
        message: 'Latest payroll period retrieved successfully',
      );
    } catch (e) {
      return ApiResponse(
        data: PayrollPeriod.empty(),
        success: false,
        message: 'Failed to retrieve latest payroll period: $e',
      );
    }
  }

  Future<ApiResponse<List<PayrollPeriod>>> getAllPayrollPeriods() async {
    try {
      final db = await _sqlService.database;
      final List<Map<String, dynamic>> maps = await db.query('payroll_periods');

      if (maps.isEmpty) {
        return ApiResponse(
          data: [],
          success: true,
          message: 'No payroll periods found',
        );
      }

      final payrollPeriods = maps
          .map((map) => PayrollPeriodDto.fromJson(map).toEntity())
          .toList();
      return ApiResponse(
        data: payrollPeriods,
        success: true,
        message: 'Payroll periods retrieved successfully',
      );
    } catch (e) {
      return ApiResponse(
        data: [],
        success: false,
        message: 'Failed to retrieve payroll periods: $e',
      );
    }
  }

  Future<ApiResponse<PayrollPeriod>> updatePayrollPeriod({
    required PayrollPeriodDto payrollPeriod,
  }) async {
    try {
      final db = await _sqlService.database;
      await db.update(
        'payroll_periods',
        payrollPeriod.toJsonWithoutId(),
        where: 'id = ?',
        whereArgs: [payrollPeriod.id],
      );
      return ApiResponse(
        data: payrollPeriod.toEntity(),
        success: true,
        message: 'Payroll period updated successfully',
      );
    } catch (e) {
      return ApiResponse(
        data: PayrollPeriod.empty(),
        success: false,
        message: 'Failed to update payroll period: $e',
      );
    }
  }

  Future<ApiResponse<PayrollPeriod>> deletePayrollPeriod(String id) async {
    try {
      final db = await _sqlService.database;
      final int count = await db.delete(
        'payroll_periods',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (count > 0) {
        return ApiResponse(
          data: PayrollPeriod.empty(),
          success: true,
          message: 'Payroll period deleted successfully',
        );
      } else {
        return ApiResponse(
          data: PayrollPeriod.empty(),
          success: false,
          message: 'Payroll period not found',
        );
      }
    } catch (e) {
      return ApiResponse(
        data: PayrollPeriod.empty(),
        success: false,
        message: 'Failed to delete payroll period: $e',
      );
    }
  }
}
