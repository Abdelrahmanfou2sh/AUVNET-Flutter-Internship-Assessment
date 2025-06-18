import 'package:auvnet/features/auth/domain/entities/user.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent({required this.email, required this.password});
}

class SignOutEvent extends AuthEvent {}

class AuthStateChangedEvent extends AuthEvent {
  final UserEntity? user;

  AuthStateChangedEvent(this.user);
}

class CheckLastSignedInUserEvent extends AuthEvent {}
