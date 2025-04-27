part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin({required this.email, required this.password});

  // authEventLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthEventRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthEventRegister(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [];
}
