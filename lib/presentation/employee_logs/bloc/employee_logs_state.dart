part of 'employee_logs_bloc.dart';

sealed class EmployeeLogsState extends Equatable {
  const EmployeeLogsState();
  
  @override
  List<Object?> get props => [];
}

final class EmployeeLogsInitial extends EmployeeLogsState {}

final class EmployeeLogsLoading extends EmployeeLogsState {}

final class EmployeeLogsLoaded extends EmployeeLogsState {
  final List<Log> logs;
  final Employee? selectedEmployee;

  const EmployeeLogsLoaded(this.logs, {this.selectedEmployee});

  @override
  List<Object?> get props => [logs, selectedEmployee];
}

final class EmployeeLogsError extends EmployeeLogsState {
  final String message;

  const EmployeeLogsError({required this.message});

  @override
  List<Object?> get props => [message];
}