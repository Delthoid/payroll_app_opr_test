import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/domain/repositories/employee_repository.dart';

class UpdateEmployee {
  final EmployeeRepository _employeeRepository;

  UpdateEmployee(this._employeeRepository);

  Future<ApiResponse<Employee>> call(Employee employee) async {
    if (employee.id.isEmpty) {
      throw Exception('Employee ID cannot be empty');
    }
    return await _employeeRepository.updateEmployee(employee);
  }
}