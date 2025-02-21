part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AppLaunchDetected extends AuthEvent {}

final class AuthenticationRequested extends AuthEvent {
  final String admno, password;
  AuthenticationRequested({required this.admno, required this.password});
}

final class RegistrationEventRequested extends AuthEvent {
  final String admno, password;
  RegistrationEventRequested({required this.admno, required this.password});
}

final class SignupEventRequested extends AuthEvent {
  UserData user;
  UserCredentialData creds;
  UserProfileData profile;
  SignupEventRequested({
    required this.user,
    required this.profile,
    required this.creds,
  });
}
