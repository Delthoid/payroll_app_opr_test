part of 'payroll_periods_bloc.dart';

sealed class PayrollPeriodsEvent extends Equatable {
  const PayrollPeriodsEvent();

  @override
  List<Object> get props => [];
}

class LoadPayrollPeriods extends PayrollPeriodsEvent {}

class AddLocalPayrollPeriod extends PayrollPeriodsEvent {
  final PayrollPeriod payrollPeriod;

  const AddLocalPayrollPeriod(this.payrollPeriod);

  @override
  List<Object> get props => [payrollPeriod];
}

class RemoveLocalPayrollPeriod extends PayrollPeriodsEvent {
  final String payrollPeriodId;

  const RemoveLocalPayrollPeriod(this.payrollPeriodId);

  @override
  List<Object> get props => [payrollPeriodId];
}