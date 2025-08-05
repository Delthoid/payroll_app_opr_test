import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
import 'package:payroll_app_opr_test/domain/repositories/employee_repository.dart';

class GetEmployees {
  final EmployeeRepository _employeeRepository;

  GetEmployees(this._employeeRepository);

  Future<ApiResponse<List<Employee>>> call() {
    return _employeeRepository.getEmployees();
  }
}