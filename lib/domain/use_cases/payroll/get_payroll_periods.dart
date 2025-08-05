import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/domain/repositories/payroll_period_repository.dart';

class GetPayrollPeriods {
  final PayrollPeriodRepository _payrollPeriodRepository;

  GetPayrollPeriods(this._payrollPeriodRepository);

  Future<ApiResponse<List<PayrollPeriod>>> call() {
    return _payrollPeriodRepository.getPayrollPeriods();
  }
}