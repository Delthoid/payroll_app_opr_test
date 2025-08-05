import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:payroll_app_opr_test/data/services/session_service.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/domain/use_cases/payroll/get_payroll_periods.dart';

part 'payroll_periods_event.dart';
part 'payroll_periods_state.dart';

class PayrollPeriodsBloc extends Bloc<PayrollPeriodsEvent, PayrollPeriodsState> {

  final GetPayrollPeriods _getPayrollPeriods = GetIt.instance<GetPayrollPeriods>();

  PayrollPeriodsBloc() : super(PayrollPeriodsInitial()) {
    on<PayrollPeriodsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadPayrollPeriods>((event, emit) async {

      final getSession = GetIt.instance<SessionService>();
      final isLoggedIn = await getSession.getCurrentSession() != null;

      if (!isLoggedIn) {
        return;
      }

      emit(PayrollPeriodsLoading());
      try {
        final response = await _getPayrollPeriods.call();
        if (response.success && response.data != null) {
          emit(PayrollPeriodsLoaded(periods: response.data!));
        } else {
          emit(PayrollPeriodsError(message: response.message ?? ''));
        }
      } catch (e) {
        emit(PayrollPeriodsError(message: e.toString()));
      }
    });

    on<AddLocalPayrollPeriod>((event, emit) {
      if (state is PayrollPeriodsLoaded) {
        final currentState = state as PayrollPeriodsLoaded;

        // Replace the existing periods with the new one
        if (currentState.periods.any((p) => p.id == event.payrollPeriod.id)) {
          final updatedPeriods = currentState.periods.map((p) {
            return p.id == event.payrollPeriod.id ? event.payrollPeriod : p;
          }).toList();

          emit(PayrollPeriodsLoaded(periods: updatedPeriods));
        }
      }
    });

    on<RemoveLocalPayrollPeriod>((event, emit) {
      if (state is PayrollPeriodsLoaded) {
        final currentState = state as PayrollPeriodsLoaded;

        // Filter out the period to be removed
        final updatedPeriods = currentState.periods.where((p) => p.id != event.payrollPeriodId).toList();

        emit(PayrollPeriodsLoaded(periods: updatedPeriods));
      }
    });
  }
}
