import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/data/dto/employee/employee_dto.dart';
import 'package:payroll_app_opr_test/data/services/employee_service.dart';
import 'package:payroll_app_opr_test/domain/entities/employee/employee.dart';
import 'package:payroll_app_opr_test/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeService _employeeService;

  EmployeeRepositoryImpl(this._employeeService);

  @override
  Future<ApiResponse<Employee>> addEmployee(Employee employee) {
    return _employeeService.addEmployee(
      EmployeeDto(
        id: employee.id,
        firstName: employee.firstName,
        lastName: employee.lastName,
        email: employee.email,
        position: employee.position,
        salary: employee.salary,
      ),
    );
  }

  @override
  Future<ApiResponse<void>> deleteEmployee(String id) {
    // TODO: implement deleteEmployee
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<Employee>> getEmployeeById(String id) {
    // TODO: implement getEmployeeById
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<List<Employee>>> getEmployees() {
    // TODO: implement getEmployees
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<Employee>> updateEmployee(Employee employee) {
    // TODO: implement updateEmployee
    throw UnimplementedError();
  }
}
