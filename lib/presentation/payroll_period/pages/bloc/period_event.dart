part of 'period_bloc.dart';

sealed class PeriodEvent extends Equatable {
  const PeriodEvent();

  @override
  List<Object> get props => [];
}

class LoadPeriodsEvent extends PeriodEvent {}

class LoadPeriodEvent extends PeriodEvent {
  final PayrollPeriod period;

  const LoadPeriodEvent({required this.period});

  @override
  List<Object> get props => [period];
}

class AddPeriodEvent extends PeriodEvent {
  final PayrollPeriod payrollPeriod;

  const AddPeriodEvent(this.payrollPeriod);

  @override
  List<Object> get props => [payrollPeriod];
}

class UpdatePeriodEvent extends PeriodEvent {
  final PayrollPeriod payrollPeriod;

  const UpdatePeriodEvent(this.payrollPeriod);

  @override
  List<Object> get props => [payrollPeriod];
}

class DeletePeriodEvent extends PeriodEvent {
  final String periodId;

  const DeletePeriodEvent(this.periodId);

  @override
  List<Object> get props => [periodId];
}