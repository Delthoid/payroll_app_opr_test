import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/core/utils/dialog_utils.dart';
import 'package:payroll_app_opr_test/core/utils/formatters.dart';
import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';
import 'package:payroll_app_opr_test/presentation/payroll_period/pages/bloc/period_bloc.dart';

class AddPayrollPeriodPage extends StatefulWidget {
  const AddPayrollPeriodPage({super.key});

  @override
  State<AddPayrollPeriodPage> createState() => _AddPayrollPeriodPageState();
}

class _AddPayrollPeriodPageState extends State<AddPayrollPeriodPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _dateFromController = TextEditingController();
  final TextEditingController _dateToController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payroll Period')),
      body: BlocConsumer<PeriodBloc, PeriodState>(
        listener: (context, state) {
          if (state is PeriodLoading) {
            DialogUtils.showLoadingDialog(context: context, message: 'Adding Payroll Period...');
          }

          if (state is PeriodSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payroll Period Added Successfully')),
            );
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

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<PeriodBloc>().add(
                            AddPeriodEvent(
                              PayrollPeriod(
                                id: '',
                                remarks: _remarks.text,
                                startDate: _startDate!,
                                endDate: _endDate!,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Save Payroll Period'),
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
