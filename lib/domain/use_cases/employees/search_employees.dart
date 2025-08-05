import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/employee.dart';
import 'package:payroll_app_opr_test/domain/repositories/employee_repository.dart';

class SearchEmployees {
  final EmployeeRepository _employeeRepository;

  SearchEmployees(this._employeeRepository);

  Future<ApiResponse<List<Employee>>> call(String query) {
    return _employeeRepository.searchEmployees(query);
  }
}