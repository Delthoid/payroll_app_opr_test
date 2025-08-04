import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc() : super(LogInitial()) {
    on<LogEvent>((event, emit) {
      
    });

    on<LoadLogs>((event, emit) {
      emit(LogInitial(
        selectedEmployee: event.selectedEmployee,
        timeInDate: event.timeInDate,
        timeOutDate: event.timeOutDate,
      ));
    });
  }
}
