import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class EmployeeLogsPage extends StatefulWidget {
  const EmployeeLogsPage({super.key});

  @override
  State<EmployeeLogsPage> createState() => _EmployeeLogsPageState();
}

class _EmployeeLogsPageState extends State<EmployeeLogsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(RouteNames.createLog);
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ListTile(
              title: Text('John Doe', style: theme.textTheme.titleMedium),
              trailing: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      '8.12',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text('Hours', style: TextStyle(color: Colors.grey)),
                ],
              ),
              subtitle: Column(
                children: [
            
                  Row(
                    children: [
                      SizedBox(width: 75, child: Text('Time In', style: TextStyle(color: Colors.grey))),
                      const SizedBox(width: 20),
                      Text('7:48AM | Aug 12, 2025', style: TextStyle()),
                    ],
                  ),
            
                  Row(
                    children: [
                      SizedBox(width: 75, child: Text('Time Out', style: TextStyle(color: Colors.grey))),
                      const SizedBox(width: 20),
                      Text('5:00PM | Aug 12, 2025', style: TextStyle()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 10,
      ),
    );
  }
}
