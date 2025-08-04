import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/core/models/user_session.dart';
import 'package:payroll_app_opr_test/domain/repositories/auth_repository.dart';

class AuthRequest {
  final AuthRepository _authRepository;

  AuthRequest(this._authRepository);

  Future<ApiResponse<UserSession>> call(String email, String password) {
    return _authRepository.login(email, password);
  }
}