import 'package:payroll_app_opr_test/core/models/user_session.dart';
import 'package:payroll_app_opr_test/domain/repositories/session_repository.dart';

class SaveSession {
  final SessionRepository _sessionRepository;

  SaveSession(this._sessionRepository);

  Future<void> call(UserSession session) async {
    await _sessionRepository.insertSession(session);
  }
}