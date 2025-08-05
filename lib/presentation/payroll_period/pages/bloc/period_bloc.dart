import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/domain/use_cases/payroll/add_payroll_period.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  final AddPayrollPeriod _addPeriodEvent = GetIt.instance<AddPayrollPeriod>();

  PeriodBloc() : super(PeriodInitial()) {
    on<PeriodEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddPeriodEvent>((event, emit) async {
      emit(PeriodLoading());
      await Future.delayed(const Duration(seconds: 2)); // Simulate loading delay
      try {
        final response = await _addPeriodEvent.call(event.payrollPeriod);
        if (response.success && response.data != null) {
          emit(
            PeriodSuccess(
              message: response.message ?? '',
              period: response.data!,
            ),
          );
        } else {
          emit(
            PeriodError(
              message: response.message ?? '',
              period: event.payrollPeriod,
            ),
          );
        }
      } catch (e) {
        emit(PeriodError(message: e.toString(), period: event.payrollPeriod));
      }
    });
  }
}
