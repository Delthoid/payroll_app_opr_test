import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class PayrollPeriodPage extends StatefulWidget {
  const PayrollPeriodPage({super.key});

  @override
  State<PayrollPeriodPage> createState() => _PayrollPeriodPageState();
}

class _PayrollPeriodPageState extends State<PayrollPeriodPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateRangeController = TextEditingController();

  DateTimeRange? _selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payroll Periods'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(RouteNames.addPayrollPeriod);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            spacing: 12,
            children: [
              TextFormField(
                controller: _dateRangeController,
                decoration: InputDecoration(hintText: 'Select Date Range'),
                onTap: () {
                  showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        _selectedDateRange = value;
                        _dateRangeController.text =
                            '${value.start} - ${value.end}';
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
