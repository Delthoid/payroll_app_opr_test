import 'package:payroll_app_opr_test/core/models/user_session.dart';
import 'package:payroll_app_opr_test/data/services/session_service.dart';
import 'package:payroll_app_opr_test/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {

  final SessionService _sessionService;

  SessionRepositoryImpl(this._sessionService);

  @override
  Future<UserSession?> getCurrentSession() {
    return _sessionService.getCurrentSession();
  }

  @override
  Future<void> insertSession(UserSession session) {
    return _sessionService.saveSession(session);
  }
}