import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';
import 'package:payroll_app_opr_test/domain/repositories/logs_repository.dart';

class DeleteLog {
  final LogsRepository _logsRepository;

  DeleteLog(this._logsRepository);

  Future<ApiResponse<Log>> call({required String logId}) async {
    return await _logsRepository.deleteLog(logId: logId);
  }
}