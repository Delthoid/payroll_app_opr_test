import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/pages/employee_logs_page.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employees_page.dart';
import 'package:payroll_app_opr_test/presentation/home/cubit/home_page_cubit.dart';
import 'package:payroll_app_opr_test/presentation/payroll_period/pages/payroll_period_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageCubit, int>(
        builder: (context, index) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: switch (index) {
              0 => const EmployeesPage(),
              1 => const EmployeeLogsPage(),
              2 => const PayrollPeriodPage(),
              _ => const Center(child: Text('Select a tab')),
            },
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: context.watch<HomePageCubit>().state,
        onDestinationSelected: (value) {
          context.read<HomePageCubit>().changeIndex(value);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.group_outlined),
            label: 'Employees',
            selectedIcon: const Icon(Icons.group),
          ),
          NavigationDestination(
            icon: const Icon(Icons.history),
            label: 'Logs',
            selectedIcon: const Icon(Icons.history),
          ),
          NavigationDestination(
            icon: const Icon(Icons.payments_outlined),
            label: 'Payroll',
            selectedIcon: const Icon(Icons.payments),
          ),
        ],
      ),
    );
  }
}
