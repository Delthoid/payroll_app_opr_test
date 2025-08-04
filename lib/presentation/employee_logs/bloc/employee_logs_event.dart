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

final class UpdateLocalLogs extends EmployeeLogsEvent {
  final Log log;

  const UpdateLocalLogs(this.log);

  @override
  List<Object?> get props => [log];
}

final class AddLocalLog extends EmployeeLogsEvent {
  final Log log;

  const AddLocalLog(this.log);

  @override
  List<Object?> get props => [log];
}