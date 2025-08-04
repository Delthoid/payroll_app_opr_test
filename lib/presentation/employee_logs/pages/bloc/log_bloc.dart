import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:payroll_app_opr_test/data/dto/log/log_dto.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/domain/entities/log.dart';
import 'package:payroll_app_opr_test/domain/use_cases/logs/add_log.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  final AddLog _addLogUseCase = GetIt.instance<AddLog>();

  LogBloc() : super(LogInitial()) {
    on<LogEvent>((event, emit) {});

    on<LoadLogs>((event, emit) {
      emit(
        LogInitial(
          selectedEmployee: event.selectedEmployee,
          timeInDate: event.timeInDate,
          timeOutDate: event.timeOutDate,
        ),
      );
    });

    on<AddLogEvent>((event, emit) async {
      emit(LogLoading());
      try {
        final response = await _addLogUseCase.call(log: event.log);

        if (response.success && response.data != null) {
          emit(
            LogSuccess(
              message: 'Log created successfully',
              log: response.data!,
            ),
          );
          emit(
            LogInitial(
              selectedEmployee: null,
              timeInDate: null,
              timeOutDate: null,
            ),
          );
        } else {
          emit(
            LogError(
              message: 'Unable to create log',
              selectedEmployee: event.log.employee,
              timeInDate: event.log.timeIn,
              timeOutDate: event.log.timeOut,
            ),
          );
        }
      } catch (e) {
        emit(LogError(message: 'Failed to create log'));
      }
    });
  }
}
