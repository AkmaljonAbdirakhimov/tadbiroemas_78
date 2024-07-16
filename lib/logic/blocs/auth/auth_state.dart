part of 'auth_bloc.dart';

sealed class AuthState {}

final class InitialAuthState extends AuthState {}

final class LoadingAuthState extends AuthState {}

final class LoggedInState extends AuthState {
  final User user;

  LoggedInState(this.user);
}

final class LoggedOutState extends AuthState {}

final class ErrorAuthState extends AuthState {
  final String error;

  ErrorAuthState(this.error);
}
