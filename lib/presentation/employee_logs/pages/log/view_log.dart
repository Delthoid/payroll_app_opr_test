import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/core/utils/dialog_utils.dart';
import 'package:payroll_app_opr_test/core/utils/formatters.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/bloc/employee_logs_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/pages/bloc/log_bloc.dart';

class ViewLog extends StatefulWidget {
  const ViewLog({super.key});

  @override
  State<ViewLog> createState() => _ViewLogState();
}

class _ViewLogState extends State<ViewLog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('View Log'),),
      body: BlocConsumer<LogBloc, LogState>(
        listener: (context, state) {
          if (state is LogLoading) {
            DialogUtils.showLoadingDialog(context: context, message: 'Please wait...');
          }

          if (state is LogSuccess) {
            Navigator.of(context).pop(); // Close loading dialog
            Navigator.of(context).pop(); // Close view log screen 
            context.read<EmployeeLogsBloc>().add(LoadEmployeeLogs());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is LogLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: theme.colorScheme.primary,
                            child: Text(
                              '${state.log.employee.firstName[0]}${state.log.employee.lastName[0]}'
                                  .toUpperCase(),
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${state.log.employee.firstName} ${state.log.employee.lastName}',
                            style: theme.textTheme.titleLarge,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              state.log.employee.position,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      spacing: 12,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Time In'),
                              const SizedBox(height: 8),
                              Text(
                                Formatters.formatTime(state.log.timeIn),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                Formatters.formatDate(state.log.timeIn),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Time Out'),
                              const SizedBox(height: 8),
                              Text(
                                Formatters.formatTime(state.log.timeOut),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                Formatters.formatDate(state.log.timeOut),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ].map((e) => Expanded(child: e)).toList(),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Total Hours',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${state.log.timeOut.difference(state.log.timeIn).inHours}h ${state.log.timeOut.difference(state.log.timeIn).inMinutes % 60}m',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[500],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final confirm =
                              await DialogUtils.showConfirmationDialog(
                                context: context,
                                title: 'Delete Log',
                                content:
                                    'Are you sure you want to delete this log?',
                              );

                          if (confirm ?? false) {
                            context.read<LogBloc>().add(
                              DeleteLogEvent(state.log.id),
                            );
                          }
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete Log'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: Text('Log details will be displayed here'),
          );
        },
      ),
    );
  }
}
