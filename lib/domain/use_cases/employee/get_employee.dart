import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/domain/repositories/employee_repository.dart';

class GetEmployee {
  final EmployeeRepository _repository;

  GetEmployee(this._repository);

  Future<ApiResponse<Employee?>> call(String employeeId) async {
    return await _repository.getEmployeeById(employeeId);
  }
}