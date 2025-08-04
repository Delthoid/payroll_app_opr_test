part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

final class AddEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  AddEmployeeEvent({required this.employee});
}

final class GetEmployeeEvent extends EmployeeEvent {
  final String employeeId;

  GetEmployeeEvent({required this.employeeId});
}

final class UpdateEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  UpdateEmployeeEvent({required this.employee});
}

final class DeleteEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  DeleteEmployeeEvent({required this.employee});
}
