import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/core/models/user_session.dart';
import 'package:payroll_app_opr_test/data/services/auth_service.dart';
import 'package:payroll_app_opr_test/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<ApiResponse<UserSession>> login(String email, String password) {
    return _authService.login(email, password);
  }
}