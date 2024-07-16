part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent(this.email, this.password);
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

final class LogoutEvent extends AuthEvent {}

final class CheckUserStateEvent extends AuthEvent {}
