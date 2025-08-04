import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/core/utils/dialog_utils.dart';
import 'package:payroll_app_opr_test/core/utils/validators.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/presentation/employees/bloc/employees_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/bloc/employee_bloc.dart';

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({super.key});

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _hourlyRateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listenWhen: (previous, current) {
        return true;
      },
      listener: (context, state) {
        if (state is EmployeeUpdating) {
          DialogUtils.showLoadingDialog(
            context: context,
            message: 'Updating employee...',
            barrierDismissible: false,
          );
        }

        if (state is EmployeeUpdated) {
          Navigator.of(context).pop(); // Close loading dialog
          Navigator.of(context).pop(); // Go back to employee list
          context.read<EmployeesBloc>().add(
            UpdateLocalEmployeeEvent(state.employee),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is EmployeeDetailsError) {
          Navigator.of(context).pop(); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        
        if (state is EmployeeLoaded) {
          _firstNameController.text = state.employee.firstName;
          _lastNameController.text = state.employee.lastName;
          _emailController.text = state.employee.email;
          _positionController.text = state.employee.position;
          _hourlyRateController.text = state.employee.hourlyRate.toString();
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Edit Employee')),
          floatingActionButton: state is EmployeeLoaded
              ? FloatingActionButton.extended(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<EmployeeBloc>().add(
                        UpdateEmployeeEvent(
                          employee: Employee(
                            id: state.employee.id,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            position: _positionController.text,
                            hourlyRate: double.parse(_hourlyRateController.text),
                          ),
                        ),
                      );
                    }
                  },
                  label: const Text('Save Changes'),
                )
              : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  children: [
                    const SizedBox.shrink(),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) => Validators.validateEmail(value),
                    ),
                    TextFormField(
                      controller: _positionController,
                      decoration: const InputDecoration(labelText: 'Position'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter position';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _hourlyRateController,
                      decoration: const InputDecoration(labelText: 'Hourly Rate'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter hourly rate';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid hourly rate';
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
