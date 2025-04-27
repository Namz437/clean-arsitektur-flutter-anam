import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/users.dart';

class UsersModel extends UserEntity {
  UsersModel(
      {required super.id,
      required super.email,
      super.name,
      required super.lastLogin,
      super.photoUrl});
  factory UsersModel.fromJson(User user) {
    return UsersModel(
      id: user.uid,
      email: user.email!,
      name: user.displayName,
      lastLogin: user.metadata.lastSignInTime!,
      photoUrl: user.photoURL,
    );
  }
}
