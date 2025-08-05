import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/domain/repositories/payroll_period_repository.dart';

class DeletePayrollPeriod {
  final PayrollPeriodRepository _payrollPeriodRepository;

  DeletePayrollPeriod(this._payrollPeriodRepository);

  Future<ApiResponse<PayrollPeriod>> call(String payrollPeriodId) {
    return _payrollPeriodRepository.deletePayrollPeriod(payrollPeriodId: payrollPeriodId);
  }
}