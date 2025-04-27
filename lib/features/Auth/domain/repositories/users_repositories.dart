import 'package:dartz/dartz.dart';

import '../entities/users.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Exception, UserEntity>> createUserWithEmailAndPassword(
    String name,
    String email,
    String password,
  );

  Future<Either<Exception, UserEntity>> signInWithGoogle();
  Future<Either<Exception, void>> signOut();
}
