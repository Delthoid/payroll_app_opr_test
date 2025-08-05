import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/payroll_period.dart';
import 'package:payroll_app_opr_test/data/services/payroll_period_service.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/domain/repositories/payroll_period_repository.dart';

class PayrollPeriodRepositoryImpl implements PayrollPeriodRepository {
  final PayrollPeriodService _payrollPeriodService;

  PayrollPeriodRepositoryImpl(this._payrollPeriodService);

  @override
  Future<ApiResponse<PayrollPeriod>> createPayrollPeriod({
    required PayrollPeriod payrollPeriod,
  }) {
    return _payrollPeriodService.createPayrollPeriod(
      payrollPeriod: PayrollPeriodDto(
        id: payrollPeriod.id,
        remarks: payrollPeriod.remarks,
        isPaid: payrollPeriod.isPaid,
        startDate: payrollPeriod.startDate,
        endDate: payrollPeriod.endDate,
      ),
    );
  }

  @override
  Future<ApiResponse<PayrollPeriod>> deletePayrollPeriod({
    required String payrollPeriodId,
  }) {
    return _payrollPeriodService.deletePayrollPeriod(payrollPeriodId);
  }

  @override
  Future<ApiResponse<List<PayrollPeriod>>> getPayrollPeriods() {
    return _payrollPeriodService.getAllPayrollPeriods();
  }

  @override
  Future<ApiResponse<PayrollPeriod>> updatePayrollPeriod({
    required PayrollPeriod payrollPeriod,
  }) {
    return _payrollPeriodService.updatePayrollPeriod(
      payrollPeriod: PayrollPeriodDto(
        id: payrollPeriod.id,
        remarks: payrollPeriod.remarks,
        isPaid: payrollPeriod.isPaid,
        startDate: payrollPeriod.startDate,
        endDate: payrollPeriod.endDate,
      ),
    );
  }
}
