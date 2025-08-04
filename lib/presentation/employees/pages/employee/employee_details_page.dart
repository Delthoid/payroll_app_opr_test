import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/core/utils/dialog_utils.dart';
import 'package:payroll_app_opr_test/core/widgets/error_container.dart';
import 'package:payroll_app_opr_test/presentation/employees/bloc/employees_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/bloc/employee_bloc.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({super.key});

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        actions: [
          BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if (state is EmployeeLoaded) {
                return IconButton(
                  onPressed: () {
                    final employeeId = state.employee.id;
                    context.goNamed(
                      RouteNames.employeeEdit,
                      pathParameters: {'employeeId': employeeId, 'id': employeeId},
                    );
                  },
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit Employee',
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),

      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        buildWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is EmployeeDeleting) {
            DialogUtils.showLoadingDialog(
              context: context,
              message: 'Deleting employee...',
              barrierDismissible: false,
            );
          }

          if (state is EmployeeDeleted) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            context.read<EmployeesBloc>().add(LoadEmployeesEvent());
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is EmployeeDetailsError) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is EmployeeLoading || state is EmployeeInitial) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeDetailsError) {
            return Center(child: ErrorContainer(errorMessage: state.message));
          }

          if (state is EmployeeLoaded && state is! EmployeeDeleted) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.5,
                        ),
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                              '${state.employee.firstName[0]}${state.employee.lastName[0]}'
                                  .toUpperCase(),
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${state.employee.firstName} ${state.employee.lastName}',
                            style: theme.textTheme.titleLarge,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              state.employee.position,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(state.employee.email),
                      subtitle: Text('Email'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text(
                        '\$${state.employee.hourlyRate.toStringAsFixed(2)}',
                      ),
                      subtitle: Text('Hourly Rate'),
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
                          final confirm = await DialogUtils.showConfirmationDialog(
                            context: context,
                            title: 'Delete Employee',
                            content:
                                'Are you sure you want to delete this employee?',
                          );

                          if (confirm ?? false) {
                            context.read<EmployeeBloc>().add(
                              DeleteEmployeeEvent(employee: state.employee),
                            );
                          }
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete Employee'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(child: Text('No employee details available'));
        },
      ),
    );
  }
}
