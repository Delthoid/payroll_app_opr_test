part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeSuccess extends EmployeeState {
  final String message;

  EmployeeSuccess(this.message);
}

final class EmployeeLoaded extends EmployeeState {
  final Employee employee;

  EmployeeLoaded(this.employee);

  @override
  List<Object?> get props => [employee];
}

final class EmployeeUpdating extends EmployeeLoaded {
  EmployeeUpdating(super.employee);

  @override
  List<Object?> get props => [employee];
}

final class EmployeeUpdated extends EmployeeLoaded {
  final String message;
  EmployeeUpdated(super.employee, this.message);

  @override
  List<Object?> get props => [employee, message];
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