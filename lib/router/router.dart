import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/presentation/auth/pages/auth_page.dart';

class RouteNames {
  static const String home = '/';
  static const String login = '/login';
  static const String employeeList = '/employeeList';
  static const String employeeDetails = '/employeeDetails';
  static const String payroll = '/payroll';
  static const String settings = '/settings';
}

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(path: RouteNames.home, builder: (context, state) => const AuthPage()),
      GoRoute(path: RouteNames.login, builder: (context, state) => const AuthPage()),
      GoRoute(path: RouteNames.employeeList, builder: (context, state) => const AuthPage()),
      GoRoute(path: RouteNames.employeeDetails, builder: (context, state) => const AuthPage()),
      GoRoute(path: RouteNames.payroll, builder: (context, state) => const AuthPage()),
      GoRoute(path: RouteNames.settings, builder: (context, state) => const AuthPage()),
    ],
  );
}
