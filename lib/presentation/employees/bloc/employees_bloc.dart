import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employees/get_employees.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {

  final GetEmployees _getEmployees = GetIt.instance<GetEmployees>();
  
  EmployeesBloc() : super(EmployeesInitial()) {
    on<EmployeesEvent>((event, emit) {
      
    });

    on<LoadEmployeesEvent>((event, emit) async {
      emit(EmployeesLoading());
      final response = await _getEmployees.call();
      
      if (response.success) {
        emit(EmployeesLoaded(response.data ?? []));
      } else {
        emit(EmployeesError(response.error ?? 'An error occurred'));
      }
    });
  }
}
