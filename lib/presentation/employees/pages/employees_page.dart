import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/presentation/employees/bloc/employees_bloc.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
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
          body: Builder(
            builder: (context) {
              if (state is EmployeesInitial || state is EmployeesLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is EmployeesLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      const SizedBox.shrink(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Search Employees',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Implement search functionality here
                        },
                      ),

                      Text('Showing ${state.employees.length} employees'),

                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final employee = state.employees[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text('${employee.firstName[0]}${employee.lastName[0]}'.toUpperCase()),
                              ),
                              title: Text(employee.firstName),
                              subtitle: Text(employee.position),
                              onTap: () {
                                
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: state.employees.length,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state is EmployeesError) {
                return Center(child: Text(state.message));
              }

              return Center(child: Text('Unexpected state: $state'));
            },
          ),
        );
      },
    );
  }
}
