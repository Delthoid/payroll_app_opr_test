import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/data/services/session_service.dart';
import 'package:payroll_app_opr_test/presentation/auth/pages/auth_page.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/add_new_employee_page.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employee/bloc/employee_bloc.dart';
import 'package:payroll_app_opr_test/presentation/employees/pages/employees_page.dart';
import 'package:payroll_app_opr_test/presentation/home/home_page.dart';
import 'package:payroll_app_opr_test/presentation/payroll_generate/pages/payroll_generate_page.dart';

class RouteNames {
  static const String home = 'home';
  static const String login = 'login';
  static const String employeeList = 'employeeList';
  static const String employeeCreate = 'employeeCreate';
  static const String employeeDetails = 'employeeDetails';
  static const String payroll = 'payroll';
}

class RoutePaths {
  static const String home = '/home';
  static const String login = '/login';
  static const String employeeList = '/employeeList';
  static const String employeeCreate = '/employeeCreate';
  static const String employeeDetails = '/employeeDetails';
  static const String payroll = '/payroll';
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

      return state.fullPath;
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
