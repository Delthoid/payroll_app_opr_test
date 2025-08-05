part of 'payroll_periods_bloc.dart';

sealed class PayrollPeriodsEvent extends Equatable {
  const PayrollPeriodsEvent();

  @override
  List<Object> get props => [];
}

class LoadPayrollPeriods extends PayrollPeriodsEvent {}