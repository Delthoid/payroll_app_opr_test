import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/add_employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {

  final AddEmployee addEmployee = GetIt.instance<AddEmployee>();

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
  }
}
