part of 'log_bloc.dart';

sealed class LogState extends Equatable {
  const LogState();
  
  @override
  List<Object?> get props => [];
}

final class LogInitial extends LogState {
  final Employee? selectedEmployee;
  final DateTime? timeInDate;
  final DateTime? timeOutDate;

  const LogInitial({this.selectedEmployee, this.timeInDate, this.timeOutDate});

  @override
  List<Object?> get props => [selectedEmployee, timeInDate, timeOutDate];
}