part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeSuccess extends EmployeeState {
  final String message;

  EmployeeSuccess(this.message);
}

final class EmployeeLoaded extends EmployeeState {
  final Employee employee;

  EmployeeLoaded(this.employee);
}

final class EmployeeDeleting extends EmployeeLoaded {
  EmployeeDeleting(super.employee);
}

final class EmployeeDeleted extends EmployeeLoaded {
  final String message;
  EmployeeDeleted(this.message) : super(Employee.empty());
}

final class EmployeeDetailsError extends EmployeeState {
  final String message;

  EmployeeDetailsError(this.message);
}