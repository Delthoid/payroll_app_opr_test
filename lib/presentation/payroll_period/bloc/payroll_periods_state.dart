part of 'payroll_periods_bloc.dart';

sealed class PayrollPeriodsState extends Equatable {
  const PayrollPeriodsState();
  
  @override
  List<Object> get props => [];
}

final class PayrollPeriodsInitial extends PayrollPeriodsState {}

final class PayrollPeriodsLoading extends PayrollPeriodsState {}

final class PayrollPeriodsLoaded extends PayrollPeriodsState {
  final List<PayrollPeriod> periods;

  const PayrollPeriodsLoaded({required this.periods});

  @override
  List<Object> get props => [periods];
}

final class PayrollPeriodsError extends PayrollPeriodsState {
  final String message;

  const PayrollPeriodsError({required this.message});

  @override
  List<Object> get props => [message];
}