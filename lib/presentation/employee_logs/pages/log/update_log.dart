import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/core/utils/dialog_utils.dart';
import 'package:payroll_app_opr_test/core/utils/formatters.dart';
import 'package:payroll_app_opr_test/data/dto/employee/employee_dto.dart';
import 'package:payroll_app_opr_test/data/dto/log/log_dto.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/pages/bloc/log_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employees/bloc/employees_bloc.dart';

class UpdateLogPage extends StatefulWidget {
  const UpdateLogPage({super.key});

  @override
  State<UpdateLogPage> createState() => _CreateLogState();
}

class _CreateLogState extends State<UpdateLogPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Employee? _selectedEmployee;
  DateTime? _timeIn;
  DateTime? _timeOut;

  final TextEditingController _timeInController = TextEditingController();
  final TextEditingController _timeOutController = TextEditingController();

  @override
  void initState() {
    final state = context.read<LogBloc>().state;
    if (state is LogLoaded) {
      _selectedEmployee = state.log.employee;
      _timeIn = state.log.timeIn;
      _timeOut = state.log.timeOut;

      _timeInController.text = Formatters.formatDateTime(_timeIn!);
      _timeOutController.text = Formatters.formatDateTime(_timeOut!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Log')),
      body: BlocConsumer<LogBloc, LogState>(
        listenWhen: (previous, current) => current != previous,
        listener: (context, state) {
          if (state is LogLoading) {
            DialogUtils.showLoadingDialog(
              context: context,
              message: 'Creating log...',
            );
          }

          if (state is LogSuccess) {
            // context.read<EmployeeLogsBloc>().add(AddLocalLog(state.log));
            Navigator.pop(context);
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is LogError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text('Select Employee'),
                    BlocBuilder<EmployeesBloc, EmployeesState>(
                      builder: (context, employees) {
                        return Autocomplete(
                          initialValue: TextEditingValue(
                            text: _selectedEmployee != null
                                ? '${_selectedEmployee!.firstName} ${_selectedEmployee!.lastName}'
                                : '',
                          ),
                          displayStringForOption: (String option) => option,
                          onSelected: (option) {
                            final employee = (employees as EmployeesLoaded)
                                .employees
                                .firstWhere(
                                  (e) =>
                                      '${e.firstName} ${e.lastName}' == option,
                                );

                            if (employee is EmployeeDto) {
                              _selectedEmployee = employee.toEntity();
                            }

                            setState(() {
                              _selectedEmployee = employee;
                            });
                          },
                          optionsBuilder: (textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<String>.empty();
                            }

                            if (employees is EmployeesLoaded) {
                              return employees.employees
                                  .where(
                                    (employee) =>
                                        employee.firstName
                                            .toLowerCase()
                                            .contains(
                                              textEditingValue.text
                                                  .toLowerCase(),
                                            ) ||
                                        employee.lastName
                                            .toLowerCase()
                                            .contains(
                                              textEditingValue.text
                                                  .toLowerCase(),
                                            ),
                                  )
                                  .map(
                                    (employee) =>
                                        '${employee.firstName} ${employee.lastName}',
                                  );
                            }

                            return const Iterable<String>.empty();
                          },
                        );
                      },
                    ),
                    Text('Time In'),
                    TextFormField(
                      readOnly: true,
                      controller: _timeInController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (_timeIn == null) {
                          return 'Please select a time in';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: _timeIn != null
                            ? Formatters.formatTime(_timeIn!)
                            : 'Select Time In',
                      ),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            _timeIn = DateTime.now().copyWith(
                              hour: time.hour,
                              minute: time.minute,
                            );
                            _timeInController.text = Formatters.formatTime(
                              _timeIn!,
                            );
                          });

                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );

                          if (date != null) {
                            setState(() {
                              _timeIn = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                _timeIn!.hour,
                                _timeIn!.minute,
                              );
                              _timeInController.text =
                                  Formatters.formatDateTime(_timeIn!);
                            });
                          } else {
                            setState(() {
                              _timeIn = null;
                              _timeInController.clear();
                            });
                          }
                        }
                      },
                    ),

                    Text('Time Out'),
                    TextFormField(
                      readOnly: true,
                      controller: _timeOutController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (_timeOut == null) {
                          return 'Please select a time out';
                        }
                        if (_timeIn != null &&
                            _timeOut != null &&
                            _timeOut!.isBefore(_timeIn!)) {
                          return 'Time out cannot be before time in';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: _timeOut != null
                            ? Formatters.formatTime(_timeOut!)
                            : 'Select Time Out',
                      ),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            _timeOut = DateTime.now().copyWith(
                              hour: time.hour,
                              minute: time.minute,
                            );
                            _timeOutController.text = Formatters.formatTime(
                              _timeOut!,
                            );
                          });

                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                              _timeIn?.year ?? 2000,
                              _timeIn?.month ?? 1,
                              _timeIn?.day ?? 1,
                            ),
                            lastDate: DateTime.now(),
                          );

                          if (date != null) {
                            setState(() {
                              _timeOut = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                _timeOut!.hour,
                                _timeOut!.minute,
                              );
                              _timeOutController.text =
                                  Formatters.formatDateTime(_timeOut!);
                            });
                          } else {
                            setState(() {
                              _timeOut = null;
                              _timeOutController.clear();
                            });
                          }
                        }
                      },
                    ),

                    const Divider(),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (_selectedEmployee == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select an employee'),
                              ),
                            );
                            return;
                          }

                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<LogBloc>().add(
                              UpdateLogEvent(
                                LogDto(
                                  id: state is LogLoaded ? state.log.id : '',
                                  employee:
                                      _selectedEmployee ?? Employee.empty(),
                                  timeIn: _timeIn ?? DateTime.now(),
                                  timeOut: _timeOut ?? DateTime.now(),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
