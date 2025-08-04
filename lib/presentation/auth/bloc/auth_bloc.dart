import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:payroll_app_opr_test/core/models/user_session.dart';
import 'package:payroll_app_opr_test/domain/use_cases/auth/auth_request.dart';
import 'package:payroll_app_opr_test/domain/use_cases/session/save_session.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRequest _authRequest = GetIt.instance<AuthRequest>();
  final SaveSession _saveSession = GetIt.instance<SaveSession>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      
    });

    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authRequest.call(event.email, event.password);
        if (response.success) {
          _saveSession.call(response.data!);
          emit(AuthSuccess(response.data ?? UserSession.empty()));
        } else {
          emit(AuthFailure(response.error ?? 'Login failed'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
