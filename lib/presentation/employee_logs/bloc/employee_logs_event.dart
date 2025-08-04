part of 'employee_logs_bloc.dart';

sealed class EmployeeLogsEvent extends Equatable {
  const EmployeeLogsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadEmployeeLogs extends EmployeeLogsEvent {
  const LoadEmployeeLogs();

  @override
  List<Object?> get props => [];
}