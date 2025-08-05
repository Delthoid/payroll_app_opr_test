import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';

abstract class PayrollPeriodRepository {
  Future<ApiResponse<PayrollPeriod>> createPayrollPeriod({required PayrollPeriod payrollPeriod});
  Future<ApiResponse<PayrollPeriod>> updatePayrollPeriod({required PayrollPeriod payrollPeriod});
  Future<ApiResponse<PayrollPeriod>> deletePayrollPeriod({required String payrollPeriodId});
  Future<ApiResponse<List<PayrollPeriod>>> getPayrollPeriods();
}