import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payroll_app_opr_test/core/models/api_response.dart';
import 'package:payroll_app_opr_test/core/models/user_session.dart';

class AuthService {
  final http.Client _client = http.Client();

  final String _baseUrl = 'https://www.yahshuapayroll.com/api/';

  Future<ApiResponse<UserSession>> login(String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('${_baseUrl}api-auth/'),
        body: {'username': email, 'password': password},
      );

      final body = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ApiResponse(
          error: body['description'] ?? 'Login failed',
          success: false,
          message: body['message'] ?? 'Login failed',
        );
      }

      return ApiResponse(
        data: UserSession.fromJson(body),
        message: body['message'] ?? 'Login successful',
        success: true,
      );

    } catch (e) {
      return ApiResponse(
        error: e.toString(),
        success: false,
        message: 'An error occurred while trying to login',
      );
    }
  }
}
