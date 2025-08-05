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

final class LogLoading extends LogInitial {
  const LogLoading({
    super.selectedEmployee,
    super.timeInDate,
    super.timeOutDate,
  });
}

final class LogSuccess extends LogState {
  final String message;
  final Log log;

  const LogSuccess({required this.message, required this.log});
}

final class LogError extends LogInitial {
  final String message;

  const LogError({required this.message, super.selectedEmployee, super.timeInDate, super.timeOutDate});

  @override
  List<Object?> get props => [message , selectedEmployee, timeInDate, timeOutDate];
}

final class LogLoaded extends LogState {
  final Log log;

  const LogLoaded({required this.log});

  @override
  List<Object?> get props => [log];
}