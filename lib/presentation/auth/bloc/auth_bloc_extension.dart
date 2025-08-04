import 'package:payroll_app_opr_test/presentation/auth/bloc/auth_bloc.dart';

extension AuthBlocExtension on AuthState {
  bool get isLoading => this is AuthLoading;
}