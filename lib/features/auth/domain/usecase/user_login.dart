import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/usecases/usecase.dart';
import 'package:blog_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:blog_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogIn implements Usecase<User, UserLoginParams> {
  AuthRepository authRepository;
  UserLogIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async{
    return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams(
      { required this.email, required this.password,});
}
