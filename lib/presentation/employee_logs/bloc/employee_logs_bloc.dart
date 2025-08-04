import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';

part 'employee_logs_event.dart';
part 'employee_logs_state.dart';

class EmployeeLogsBloc extends Bloc<EmployeeLogsEvent, EmployeeLogsState> {
  EmployeeLogsBloc() : super(EmployeeLogsInitial()) {
    on<EmployeeLogsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
