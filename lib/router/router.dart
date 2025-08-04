import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/data/services/session_service.dart';
import 'package:payroll_app_opr_test/presentation/auth/pages/auth_page.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/pages/create_log.dart';
import 'package:payroll_app_opr_test/presentation/employee_logs/pages/employee_logs_page.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/add_new_employee_page.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/bloc/employee_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/edit_employee_page.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/employee_details_page.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employees_page.dart';
import 'package:payroll_app_opr_test/presentation/home/home_page.dart';
import 'package:payroll_app_opr_test/presentation/payroll_generate/pages/payroll_generate_page.dart';

class RouteNames {
  static const String home = 'home';
  static const String login = 'login';
  static const String employeeList = 'employeeList';
  static const String employeeCreate = 'employeeCreate';
  static const String employeeDetails = 'employeeDetails';
  static const String employeeEdit = 'employeeEdit';
  static const String payroll = 'payroll';

  static const String employeeLogs = 'employeeLogs';
  static const String createLog = 'createLog';
}

class RoutePaths {
  static const String home = '/home';
  static const String login = '/login';
  static const String employeeList = '/employeeList';
  static const String employeeCreate = '/employeeCreate';
  static const String employeeDetails = '/employeeDetails/:id';
  static const String employeeEdit = '/employeeEdit/:employeeId';
  static const String payroll = '/payroll';

  static const String employeeLogs = '/employeeLogs';
  static const String createLog = '/createLog';
}

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RoutePaths.login,
    redirect: (context, state) async {
      final getSession = GetIt.instance<SessionService>();
      final isLoggedIn = await getSession.getCurrentSession() != null;

      if (isLoggedIn && state.fullPath == RoutePaths.login) {
        return RoutePaths.home;
      }

      if (!isLoggedIn) {
        return RoutePaths.login;
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AuthPage()),
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: RoutePaths.employeeList,
        name: RouteNames.employeeList,
        builder: (context, state) => EmployeesPage(),
        routes: [
          GoRoute(
            path: RoutePaths.employeeCreate,
            name: RouteNames.employeeCreate,
            builder: (context, state) => BlocProvider(
              create: (context) => EmployeeBloc(),
              child: AddNewEmployeePage(),
            ),
          ),
          GoRoute(
            path: RoutePaths.employeeDetails,
            name: RouteNames.employeeDetails,
            builder: (context, state) {
              final employeeId = state.pathParameters['id'];
              if (employeeId == null) {
                return const Center(child: Text('Employee ID is required'));
              }
              return const EmployeeDetailsPage();
            },
            routes: [
              GoRoute(
                path: RoutePaths.employeeEdit,
                name: RouteNames.employeeEdit,
                builder: (context, state) {
                  final employeeId = state.pathParameters['employeeId'];
                  if (employeeId == null) {
                    return const Center(child: Text('Employee ID is required'));
                  }
                  return EditEmployeePage();
                },
              ),
            ]
          ),
        ],
      ),
      GoRoute(path: RoutePaths.employeeLogs,
        name: RouteNames.employeeLogs,
        builder: (context, state) => const EmployeeLogsPage(),
        routes: [
          GoRoute(
            path: RoutePaths.createLog,
            name: RouteNames.createLog,
            builder: (context, state) => const CreateLog(),
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.payroll,
        name: RouteNames.payroll,
        builder: (context, state) => const PayrollGeneratePage(),
      ),
    ],
  );
}
