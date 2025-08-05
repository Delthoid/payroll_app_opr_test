import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/core/utils/formatters.dart';
import 'package:payroll_app_opr_test/core/widgets/error_container.dart';
import 'package:payroll_app_opr_test/presentation/payroll_period/bloc/payroll_periods_bloc.dart';
import 'package:payroll_app_opr_test/presentation/payroll_period/pages/bloc/period_bloc.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class PayrollPeriodPage extends StatefulWidget {
  const PayrollPeriodPage({super.key});

  @override
  State<PayrollPeriodPage> createState() => _PayrollPeriodPageState();
}

class _PayrollPeriodPageState extends State<PayrollPeriodPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payroll Periods'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<PayrollPeriodsBloc>().add(LoadPayrollPeriods());
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(RouteNames.addPayrollPeriod);
            },
          ),
        ],
      ),
      body: BlocConsumer<PayrollPeriodsBloc, PayrollPeriodsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is PayrollPeriodsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PayrollPeriodsError) {
            return Center(child: ErrorContainer(errorMessage: state.message));
          }

          if (state is PayrollPeriodsLoaded) {
            if (state.periods.isEmpty) {
              return Center(child: Text('No payroll periods available.'));
            }

            return ListView.builder(
              itemCount: state.periods.length,
              itemBuilder: (context, index) {
                final period = state.periods[index];

                return ListTile(
                  title: period.remarks.isEmpty ? Text('-') : Text(period.remarks),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: period.isPaid
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4,
                      ),
                      child: Text(
                        period.isPaid ? 'Paid' : 'Unpaid',
                        style: TextStyle(
                          color: period.isPaid ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    '${Formatters.formatDate(period.startDate)} - ${Formatters.formatDate(period.endDate)}',
                  ),
                  onTap: () {
                    context.read<PeriodBloc>().add(
                      LoadPeriodEvent(period: period),
                    );
                    context.pushNamed(RouteNames.editPayrollPeriod);
                  },
                );
              },
            );
          }

          return Center(child: Text('Unexpected state: $state'));
        },
      ),
    );
  }
}
