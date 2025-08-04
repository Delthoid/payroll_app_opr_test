part of 'log_bloc.dart';

sealed class LogEvent extends Equatable {
  const LogEvent();

  @override
  List<Object?> get props => [];
}

class LoadLogs extends LogEvent {
  final Employee? selectedEmployee;
  final DateTime? timeInDate;
  final DateTime? timeOutDate;

  const LoadLogs({this.selectedEmployee, this.timeInDate, this.timeOutDate});

  @override
  List<Object?> get props => [selectedEmployee, timeInDate, timeOutDate];
}

class AddLogEvent extends LogEvent {
  final LogDto log;

  const AddLogEvent(this.log);

  @override
  List<Object?> get props => [log];
} 