part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

final class AddEmployeeEvent extends EmployeeEvent {
  final Employee employee;

  AddEmployeeEvent({required this.employee});
}