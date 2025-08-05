import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/core/utils/formatters.dart';
import 'package:payroll_app_opr_test/core/widgets/error_container.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/bloc/employee_logs_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/pages/bloc/log_bloc.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class EmployeeLogsPage extends StatefulWidget {
  const EmployeeLogsPage({super.key});

  @override
  State<EmployeeLogsPage> createState() => _EmployeeLogsPageState();
}

class _EmployeeLogsPageState extends State<EmployeeLogsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Logs'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<EmployeeLogsBloc>().add(LoadEmployeeLogs());
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(RouteNames.createLog);
            },
          ),
        ],
      ),
      body: BlocConsumer<EmployeeLogsBloc, EmployeeLogsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is EmployeeLogsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeLogsError) {
            return Center(child: ErrorContainer(errorMessage: state.message));
          }

          if (state is EmployeeLogsLoaded) {
            if (state.logs.isEmpty) {
              return const Center(child: Text('No logs available'));
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                final log = state.logs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ListTile(
                    title: Text(
                      '${log.employee.firstName} ${log.employee.lastName}',
                      style: theme.textTheme.titleMedium,
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${log.hoursWorked.toStringAsFixed(2)} hrs',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 75,
                              child: Text(
                                'Time In',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              '${Formatters.formatTime(log.timeIn)} | ${Formatters.formatDate(log.timeIn)}',
                              style: TextStyle(),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            SizedBox(
                              width: 75,
                              child: Text(
                                'Time Out',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              '${Formatters.formatTime(log.timeOut)} | ${Formatters.formatDate(log.timeOut)}',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      context.read<LogBloc>().add(LoadLogEvent(log));
                      context.pushNamed(RouteNames.viewLog);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.logs.length,
            );
          }

          return const Center(child: Text('No logs available'));
        },
      ),
    );
  }
}
