part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeSuccess extends EmployeeState {
  final String message;

  EmployeeSuccess(this.message);
}