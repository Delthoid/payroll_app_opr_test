import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:payroll_app_opr_test/data/services/session_service.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';
import 'package:payroll_app_opr_test/domain/use_cases/logs/get_logs.dart';

part 'employee_logs_event.dart';
part 'employee_logs_state.dart';

class EmployeeLogsBloc extends Bloc<EmployeeLogsEvent, EmployeeLogsState> {

  final GetLogs _getLogs = GetIt.instance<GetLogs>();

  EmployeeLogsBloc() : super(EmployeeLogsInitial()) {
    on<EmployeeLogsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadEmployeeLogs>((event, emit) async {
      final getSession = GetIt.instance<SessionService>();
      final isLoggedIn = await getSession.getCurrentSession() != null;

      if (isLoggedIn) {
        emit(EmployeeLogsLoading());
        try {
          final response = await _getLogs.call();
          emit(EmployeeLogsLoaded(response.data ?? []));
        } catch (e) {
          emit(EmployeeLogsError(message: e.toString()));
        }
      } else {
        return;
      }
    });

    on<UpdateLocalLogs>((event, emit) {
      if (state is EmployeeLogsLoaded) {
        final currentState = state as EmployeeLogsLoaded;
        final updatedLogs = currentState.logs.map((log) {
          return log.id == event.log.id ? event.log : log;
        }).toList();
        
        emit(EmployeeLogsLoaded(updatedLogs, selectedEmployee: currentState.selectedEmployee));
      }
    });

    on<AddLocalLog>((event, emit) {
      if (state is EmployeeLogsLoaded) {
        final currentState = state as EmployeeLogsLoaded;
        final updatedLogs = [event.log, ...currentState.logs];

        emit(EmployeeLogsLoaded(updatedLogs, selectedEmployee: currentState.selectedEmployee));
      }
    });
  }
}
