
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/add_employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/delete_employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/get_employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/update_employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {

  final AddEmployee addEmployee = GetIt.instance<AddEmployee>();
  final GetEmployee getEmployee = GetIt.instance<GetEmployee>();
  final UpdateEmployee updateEmployee = GetIt.instance<UpdateEmployee>();
  final DeleteEmployee deleteEmployee = GetIt.instance<DeleteEmployee>();

  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddEmployeeEvent>((event, emit) async {
      try {
        emit(EmployeeLoading());
        final result = await addEmployee.call(event.employee);
        emit(EmployeeSuccess('Employee added successfully'));
        var a = this;
      } catch (e) {
        emit(EmployeeInitial());
        return;
      }
    });

    on<GetEmployeeEvent>((event, emit) async {
      try {
        emit(EmployeeLoading());
        final result = await getEmployee.call(event.employeeId);
        if (result.data != null) {
          emit(EmployeeLoaded(result.data!));
        } else {
          emit(EmployeeDetailsError('Employee not found'));
        }
      } catch (e) {
        emit(EmployeeDetailsError('Failed to load employee'));
      }
    });

    on<UpdateEmployeeEvent>((event, emit) async {
      try {
        emit(EmployeeUpdating(event.employee));

        final result = await updateEmployee.call(event.employee);
        if(result.success) {
          emit(EmployeeUpdated(result.data!, 'Employee updated successfully'));
        } else {
          emit(EmployeeDetailsError('Failed to update employee'));
        }
      } catch (e) {
        emit(EmployeeDetailsError('Failed to update employee'));
      }
    });

    on<DeleteEmployeeEvent>((event, emit) async {
      try {
        emit(EmployeeDeleting(event.employee));
        
        final result = await deleteEmployee.call(event.employee.id);
        if(result.success) {
          emit(EmployeeDeleted(result.message ?? 'Employee deleted successfully'));
        } else {
          emit(EmployeeDetailsError('Failed to delete employee'));
        }
      } catch (e) {
        emit(EmployeeDetailsError('Failed to delete employee'));
      }
    });
  }
}
