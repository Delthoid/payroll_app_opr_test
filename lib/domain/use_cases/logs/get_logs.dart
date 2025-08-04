import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';
import 'package:payroll_app_opr_test/domain/repositories/logs_repository.dart';

class GetLogs {
  final LogsRepository _logsRepository;

  GetLogs(this._logsRepository);

  Future<ApiResponse<List<Log>>> call() async {
    return await _logsRepository.getLogs();
  }
}