import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/domain/repositories/payroll_period_repository.dart';

class UpdatePayrollPeriod {
  final PayrollPeriodRepository _payrollPeriodRepository;

  UpdatePayrollPeriod(this._payrollPeriodRepository);

  Future<ApiResponse<PayrollPeriod>> call(PayrollPeriod payrollPeriod) {
    return _payrollPeriodRepository.updatePayrollPeriod(payrollPeriod: payrollPeriod);
  }
}