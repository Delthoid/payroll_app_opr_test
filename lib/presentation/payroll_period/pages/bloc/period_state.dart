part of 'period_bloc.dart';

sealed class PeriodState extends Equatable {
  const PeriodState();
  
  @override
  List<Object> get props => [];
}

final class PeriodInitial extends PeriodState {}

final class PeriodLoading extends PeriodState {}
final class PeriodLoaded extends PeriodState {
  final PayrollPeriod period;
  const PeriodLoaded({required this.period});
}

final class PeriodSuccess extends PeriodLoaded {
  final String message;
  const PeriodSuccess({required this.message, required super.period});
}

final class PeriodError extends PeriodLoaded {
  final String message;
  const PeriodError({required this.message, required super.period});
}