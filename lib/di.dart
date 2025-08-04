import 'package:get_it/get_it.dart';
import 'package:payroll_app_opr_test/data/repositories/auth_repository_impl.dart';
import 'package:payroll_app_opr_test/data/repositories/employee_repository_impl.dart';
import 'package:payroll_app_opr_test/data/repositories/logs_repository_impl.dart';
import 'package:payroll_app_opr_test/data/repositories/session_repository_impl.dart';
import 'package:payroll_app_opr_test/data/services/auth_service.dart';
import 'package:payroll_app_opr_test/data/services/employee_service.dart';
import 'package:payroll_app_opr_test/data/services/employees_service.dart';
import 'package:payroll_app_opr_test/data/services/logs_service.dart';
import 'package:payroll_app_opr_test/data/services/session_service.dart';
import 'package:payroll_app_opr_test/data/services/sql_service.dart';
import 'package:payroll_app_opr_test/domain/repositories/auth_repository.dart';
import 'package:payroll_app_opr_test/domain/repositories/employee_repository.dart';
import 'package:payroll_app_opr_test/domain/repositories/logs_repository.dart';
import 'package:payroll_app_opr_test/domain/repositories/session_repository.dart';
import 'package:payroll_app_opr_test/domain/use_cases/auth/auth_request.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/add_employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/delete_employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/get_employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employee/update_employee.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employees/get_employees.dart';
import 'package:payroll_app_opr_test/domain/use_cases/employees/search_employees.dart';
import 'package:payroll_app_opr_test/domain/use_cases/logs/add_log.dart';
import 'package:payroll_app_opr_test/domain/use_cases/logs/delete_log.dart';
import 'package:payroll_app_opr_test/domain/use_cases/logs/get_logs.dart';
import 'package:payroll_app_opr_test/domain/use_cases/logs/update_log.dart';
import 'package:payroll_app_opr_test/domain/use_cases/session/save_session.dart';

final getIt = GetIt.instance;

void setup() {
  // Use cases
  getIt.registerLazySingleton<AuthRequest>(() => AuthRequest(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SaveSession>(() => SaveSession(getIt<SessionRepository>()));

  getIt.registerLazySingleton<AddEmployee>(() => AddEmployee(getIt<EmployeeRepository>()));
  getIt.registerLazySingleton<GetEmployee>(() => GetEmployee(getIt<EmployeeRepository>()));
  getIt.registerLazySingleton<DeleteEmployee>(() => DeleteEmployee(getIt<EmployeeRepository>()));
  getIt.registerLazySingleton<UpdateEmployee>(() => UpdateEmployee(getIt<EmployeeRepository>()));

  getIt.registerLazySingleton<GetEmployees>(() => GetEmployees(getIt<EmployeeRepository>()));
  getIt.registerLazySingleton<SearchEmployees>(() => SearchEmployees(getIt<EmployeeRepository>()));

  getIt.registerLazySingleton<AddLog>(() => AddLog(getIt<LogsRepository>()));
  getIt.registerLazySingleton<DeleteLog>(() => DeleteLog(getIt<LogsRepository>()));
  getIt.registerLazySingleton<GetLogs>(() => GetLogs(getIt<LogsRepository>()));
  getIt.registerLazySingleton<UpdateLog>(() => UpdateLog(getIt<LogsRepository>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthService>()));
  getIt.registerLazySingleton<SessionRepository>(() => SessionRepositoryImpl(getIt<SessionService>()));
  getIt.registerLazySingleton<EmployeeRepository>(() => EmployeeRepositoryImpl(getIt<EmployeeService>(), getIt<EmployeesService>()));
  getIt.registerLazySingleton<LogsRepository>(() => LogsRepositoryImpl(getIt<LogsService>()));

  // Services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<SqlService>(() => SqlService());
  getIt.registerLazySingleton<SessionService>(() => SessionService(getIt<SqlService>()));
  getIt.registerLazySingleton<EmployeeService>(() => EmployeeService(getIt<SqlService>()));
  getIt.registerLazySingleton<EmployeesService>(() => EmployeesService(getIt<SqlService>()));
  getIt.registerLazySingleton<LogsService>(() => LogsService(getIt<SqlService>()));
}