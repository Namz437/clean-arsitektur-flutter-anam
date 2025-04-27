import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/users.dart';
import '../repositories/users_repositories.dart';

class SignInWithEmail implements UseCase<UserEntity, SignInWithEmailParams> {
  final AuthRepository repository;

  SignInWithEmail({required this.repository});

  @override
  Future<Either<Exception, UserEntity>> call(
      SignInWithEmailParams params) async {
    return await repository.signInWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

class SignInWithEmailParams {
  final String email;
  final String password;

  SignInWithEmailParams({required this.email, required this.password});
}

class RegisterWithEmail
    implements UseCase<UserEntity, RegisterWithEmailParams> {
  final AuthRepository repository;

  RegisterWithEmail({required this.repository});

  @override
  Future<Either<Exception, UserEntity>> call(
      RegisterWithEmailParams params) async {
    return await repository.createUserWithEmailAndPassword(
      params.name,
      params.email,
      params.password,
    );
  }
}

class RegisterWithEmailParams {
  final String name;
  final String email;
  final String password;

  RegisterWithEmailParams({required this.name, required this.email, required this.password});
}