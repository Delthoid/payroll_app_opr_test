part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequest extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequest(this.email, this.password);
}