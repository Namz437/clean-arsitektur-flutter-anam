part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthStateInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateLoaded extends AuthState {
  final UserEntity usermodel;

  AuthStateLoaded(this.usermodel);

  @override
  List<Object?> get props => [usermodel];
}

class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthStateSuccess extends AuthState {
  final User? user;

  AuthStateSuccess({this.user});

  @override
  List<Object?> get props => [];
}