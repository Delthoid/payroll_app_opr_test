import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          Tooltip(
            message: 'Add Employee',
            child: IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                context.pushNamed(RouteNames.employeeCreate);
              },
            ),
          ),
        ],
      ),
      body: Center(child: Text('Employees Page Content')),
    );
  }
}
