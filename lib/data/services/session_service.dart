import 'package:payroll_app_opr_test/core/models/user_session.dart';
import 'package:payroll_app_opr_test/data/services/sql_service.dart';

class SessionService {
  final SqlService _sqlService;

  SessionService(this._sqlService);

  Future<void> saveSession(UserSession session) async {
    await _sqlService.insertSession(session: session);
  }

  Future<List<UserSession>> getSessions() async {
    return await _sqlService.getSessions();
  }

  Future<UserSession?> getCurrentSession() async {
    final sessions = await _sqlService.getSessions();
    if (sessions.isNotEmpty) {
      return sessions.first; // Assuming the first session is the current one
    }
    return null;
  }

  Future<void> close() async {
    await _sqlService.closeDatabase();
  }
}