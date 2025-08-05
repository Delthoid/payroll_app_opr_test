import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
import 'package:payroll_app_opr_test/domain/repositories/employee_repository.dart';

class AddEmployee {
  final EmployeeRepository _employeeRepository;

  AddEmployee(this._employeeRepository);

  Future<ApiResponse<Employee>> call(Employee employee) {
    return _employeeRepository.addEmployee(employee);
  }
}