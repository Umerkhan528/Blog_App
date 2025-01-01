import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/usecases/usecase.dart';
import 'package:blog_clean_architecture/core/common/entities/user.dart';
import 'package:blog_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignup implements Usecase<User, UserSignupParams> {
  AuthRepository authRepository;
  UserSignup(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async{
   return await authRepository.signUpWithEmailPassword(email: params.email, password: params.password, name: params.name);
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;
  UserSignupParams(
      {required this.name, required this.email, required this.password,});
}
