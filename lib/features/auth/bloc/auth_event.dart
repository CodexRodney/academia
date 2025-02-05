part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AppLaunchDetected extends AuthEvent {}

final class AuthenticationRequested extends AuthEvent {
  final String admno, password;
  AuthenticationRequested({required this.admno, required this.password});
}
