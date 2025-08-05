import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/core/utils/dialog_utils.dart';
import 'package:payroll_app_opr_test/core/utils/formatters.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/presentation/payroll_period/bloc/payroll_periods_bloc.dart';
import 'package:payroll_app_opr_test/presentation/payroll_period/pages/bloc/period_bloc.dart';

class UpdatePayrollPeriodPage extends StatefulWidget {
  const UpdatePayrollPeriodPage({super.key});

  @override
  State<UpdatePayrollPeriodPage> createState() => _UpdatePayrollPeriodPageState();
}

class _UpdatePayrollPeriodPageState extends State<UpdatePayrollPeriodPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _dateFromController = TextEditingController();
  final TextEditingController _dateToController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isPaid = false;

  @override
  void initState() {
    final state = context.read<PeriodBloc>().state;
    
    if (state is PeriodLoaded) {
      _remarks.text = state.period.remarks ?? '';
      _startDate = state.period.startDate;
      _endDate = state.period.endDate;
      _dateFromController.text = Formatters.formatDateLong(_startDate!);
      _dateToController.text = Formatters.formatDateLong(_endDate!);
      _isPaid = state.period.isPaid;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Payroll Period')),
      body: BlocConsumer<PeriodBloc, PeriodState>(
        listener: (context, state) {
          if (state is PeriodLoading) {
            DialogUtils.showLoadingDialog(context: context, message: 'Updating Payroll Period...');
            return;
          }

          if (state is PeriodSuccess) {
            if (state.period.id.isEmpty) {
              context.read<PayrollPeriodsBloc>().add(LoadPayrollPeriods());
            } else {
              context.read<PayrollPeriodsBloc>().add(AddLocalPayrollPeriod(state.period));
            }

            
            Navigator.pop(context);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            return;
          }

          if (state is PeriodError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 12,
                children: [
                  TextFormField(
                    controller: _remarks,
                    decoration: InputDecoration(labelText: 'Remarks (Optional)'),
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _dateFromController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(labelText: 'Start Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a start date';
                      }
                      return null;
                    },
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: _endDate ?? DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _startDate = pickedDate;
                          _dateFromController.text = Formatters.formatDateLong(
                            pickedDate,
                          );
                        });
                      }
                    },
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _dateToController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(labelText: 'End Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an end date';
                      }
                      return null;
                    },
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: _startDate ?? DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _endDate = pickedDate;
                          _dateToController.text = Formatters.formatDateLong(
                            pickedDate,
                          );
                        });
                      }
                    },
                  ),

                  CheckboxListTile(
                    value: _isPaid,
                    title: Text('Mark as Paid'),
                    onChanged: (value) {
                      setState(() {
                        _isPaid = value ?? false;
                      });
                    },
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<PeriodBloc>().add(
                            UpdatePeriodEvent(
                              PayrollPeriod(
                                id: (state as PeriodLoaded).period.id,
                                remarks: _remarks.text,
                                startDate: _startDate!,
                                endDate: _endDate!,
                                isPaid: _isPaid,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Update Payroll Period'),
                    ),
                  ),

                  const Divider(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        final confirm = await DialogUtils.showConfirmationDialog(
                          context: context,
                          title: 'Delete Payroll Period',
                          content: 'Are you sure you want to delete this payroll period?',
                        );
                        if (confirm == true) {
                          context.read<PeriodBloc>().add(
                            DeletePeriodEvent((state as PeriodLoaded).period.id),
                          );
                        }
                      },
                      child: const Text('Delete Payroll Period'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
