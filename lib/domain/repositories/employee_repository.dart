import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';

abstract class EmployeeRepository {
  Future<ApiResponse<List<Employee>>> getEmployees();
  Future<ApiResponse<Employee>> getEmployeeById(String id);
  Future<ApiResponse<Employee>> addEmployee(Employee employee);
  Future<ApiResponse<Employee>> updateEmployee(Employee employee);
  Future<ApiResponse<void>> deleteEmployee(String id);
}
