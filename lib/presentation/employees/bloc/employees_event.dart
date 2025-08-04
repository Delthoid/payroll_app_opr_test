part of 'employees_bloc.dart';

@immutable
sealed class EmployeesEvent {}

final class LoadEmployeesEvent extends EmployeesEvent {}

final class UpdateLocalEmployeeEvent extends EmployeesEvent {
  final Employee employee;

  UpdateLocalEmployeeEvent(this.employee);
}

final class SearchEmployeesEvent extends EmployeesEvent {
  final String query;

  SearchEmployeesEvent(this.query);
}