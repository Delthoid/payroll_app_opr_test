import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/domain/use_cases/payroll/add_payroll_period.dart';
import 'package:payroll_app_opr_test/domain/use_cases/payroll/delete_payroll_period.dart';
import 'package:payroll_app_opr_test/domain/use_cases/payroll/update_payroll_period.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  final AddPayrollPeriod _addPeriodEvent = GetIt.instance<AddPayrollPeriod>();
  final UpdatePayrollPeriod _updatePeriodEvent = GetIt.instance<UpdatePayrollPeriod>();
  final DeletePayrollPeriod _deletePeriodEvent = GetIt.instance<DeletePayrollPeriod>();

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

    on<LoadPeriodEvent>((event, emit) async {
      emit(PeriodLoaded(period: event.period));
    });

    on<UpdatePeriodEvent>((event, emit) async {
      emit(PeriodLoading());
      try {
        final response = await _updatePeriodEvent.call(event.payrollPeriod);
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

    on<DeletePeriodEvent>((event, emit) async {
      emit(PeriodLoading());
      try {
        final response = await _deletePeriodEvent.call(event.periodId);
        if (response.success) {
          emit(PeriodSuccess(message: response.message ?? '', period: PayrollPeriod.empty()));
        } else {
          emit(PeriodError(message: response.message ?? '', period: PayrollPeriod.empty()));
        }
      } catch (e) {
        emit(PeriodError(message: e.toString(), period: PayrollPeriod.empty()));
      }
    });
  }
}
