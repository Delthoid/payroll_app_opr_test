import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/core/utils/validators.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/bloc/employee_bloc.dart';

class AddNewEmployeePage extends StatefulWidget {
  const AddNewEmployeePage({super.key});

  @override
  State<AddNewEmployeePage> createState() => _AddNewEmployeePageState();
}

class _AddNewEmployeePageState extends State<AddNewEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeLoading) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20),
                    Text('Adding Employee...'),
                  ],
                ),
              );
            },
          );
        }

        if (state is EmployeeSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is EmployeeInitial) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Add New Employee')),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<EmployeeBloc>().add(
                  AddEmployeeEvent(
                    employee: Employee(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      position: _positionController.text,
                      salary: double.parse(_salaryController.text),
                      id: '',
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the first name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the last name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => Validators.validateEmail(value),
                    ),
                    TextFormField(
                      controller: _positionController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Position',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the position';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _salaryController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Salary',
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the salary';
                        }

                        final salary = double.tryParse(value);
                        if (salary == null || salary <= 0) {
                          return 'Please enter a valid salary';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
