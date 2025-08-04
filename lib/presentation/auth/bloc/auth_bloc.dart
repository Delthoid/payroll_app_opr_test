import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:payroll_app_opr_test/domain/use_cases/auth/auth_request.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRequest _authRequest = GetIt.instance<AuthRequest>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      
    });

    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authRequest.call(event.email, event.password);
        if (response.success) {
          emit(AuthSuccess(response.data ?? 'Login successful'));
        } else {
          emit(AuthFailure(response.error ?? 'Login failed'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
