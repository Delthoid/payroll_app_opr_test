import 'package:payroll_app_opr_test/core/models/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse<String>> login(String email, String password);
}