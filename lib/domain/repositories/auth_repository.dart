import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/core/models/user_session.dart';

abstract class AuthRepository {
  Future<ApiResponse<UserSession>> login(String email, String password);
}