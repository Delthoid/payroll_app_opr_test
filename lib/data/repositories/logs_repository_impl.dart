import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/log/log_dto.dart';
import 'package:payroll_app_opr_test/data/services/logs_service.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';
import 'package:payroll_app_opr_test/domain/repositories/logs_repository.dart';

class LogsRepositoryImpl implements LogsRepository {
  final LogsService _logsService;

  LogsRepositoryImpl(this._logsService);

  @override
  Future<ApiResponse<Log>> deleteLog({required String logId}) {
    return _logsService.deleteLog(logId: logId);
  }

  @override
  Future<ApiResponse<List<Log>>> getLogs() {
    return _logsService.getLogs();
  }

  @override
  Future<ApiResponse<Log>> insertLog({required Log log}) {
    return _logsService.insertLog(
      log: LogDto(
        id: log.id,
        employee: log.employee,
        timeIn: log.timeIn,
        timeOut: log.timeOut,
      ),
    );
  }

  @override
  Future<ApiResponse<Log>> updateLog({required Log log}) {
    return _logsService.updateLog(
      log: LogDto(
        id: log.id,
        employee: log.employee,
        timeIn: log.timeIn,
        timeOut: log.timeOut,
      ),
    );
  }
}
