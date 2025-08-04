import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';
import 'package:payroll_app_opr_test/domain/repositories/logs_repository.dart';

class AddLog {
  final LogsRepository _logsRepository;

  AddLog(this._logsRepository);

  Future<ApiResponse<Log>> call({required Log log}) async {
    return await _logsRepository.insertLog(log: log);
  }
}