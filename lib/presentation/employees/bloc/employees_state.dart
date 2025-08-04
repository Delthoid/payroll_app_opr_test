part of 'employees_bloc.dart';

@immutable
sealed class EmployeesState {}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesLoading extends EmployeesState {}

final class EmployeesLoaded extends EmployeesState {
  final List<Employee> employees;

  EmployeesLoaded(this.employees);
}

final class EmployeesError extends EmployeesState {
  final String message;

  EmployeesError(this.message);
}
