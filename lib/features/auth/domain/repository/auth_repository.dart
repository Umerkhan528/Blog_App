import "package:blog_clean_architecture/core/errors/failure.dart";
import "package:blog_clean_architecture/features/auth/data/model/user_model.dart";
import "package:fpdart/fpdart.dart";

import "../../../../core/common/entities/user.dart";

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
