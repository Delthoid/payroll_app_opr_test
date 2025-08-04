import 'package:payroll_app_opr_test/core/models/api_response.dart';

class AuthService {
  
  final String _email = "admin@payrollapp.com";
  final String _password = "admin123";
  
  Future<ApiResponse<String>> login(String email, String password) async{
    // Demonstration of a login method

    // Simulate delay
    await Future.delayed(Duration(seconds: 2));

    if (email.trim() == _email && password.trim() == _password) {
      return ApiResponse<String>(
        data: "Login successful",
        success: true,
        message: "Welcome back!",
      );
    } else {
      return ApiResponse<String>(
        success: false,
        error: "Invalid email or password",
        message: "Please try again.",
      );
    }
  }
}