import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';

class Log {
  final String id;
  final Employee employee;
  final DateTime timeIn;
  final DateTime timeOut;

  Log({
    required this.id,
    required this.employee,
    required this.timeIn,
    required this.timeOut,
  });

  // Empty
  Log.empty()
      : id = '',
        employee = Employee.empty(),
        timeIn = DateTime.now(),
        timeOut = DateTime.now();

  double get hoursWorked {
    final duration = timeOut.difference(timeIn);
    return duration.inHours + (duration.inMinutes % 60) / 60.0;
  }
}