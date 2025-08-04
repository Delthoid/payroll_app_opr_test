import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';

abstract class LogsRepository {
  Future<ApiResponse<Log>> insertLog({required Log log});
  Future<ApiResponse<List<Log>>> getLogs();
  Future<ApiResponse<Log>> deleteLog({required String logId});
  Future<ApiResponse<Log>> updateLog({required Log log});
}