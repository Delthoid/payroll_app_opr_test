import 'package:payroll_app_opr_test/core/models/user_session.dart';

abstract class SessionRepository {
  Future<UserSession?> getCurrentSession();
  Future<void> insertSession(UserSession session);
}