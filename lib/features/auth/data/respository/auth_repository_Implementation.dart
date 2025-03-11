import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/errors/server_exception.dart';
import 'package:blog_clean_architecture/core/networks/check_internet.dart';
import 'package:blog_clean_architecture/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:blog_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource remoteDataSource;
  CheckConnection checkConnection;
  AuthRepositoryImpl(this.remoteDataSource,this.checkConnection);


  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) {
    return _getUser(() async =>
    await remoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email, required String password, required String name,}) async {
    return _getUser(() async =>
    await remoteDataSource.signUpWithEmailPassword(
        email: email, password: password, name: name));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn,) async {
    try {
      if(! await (checkConnection.isConnection)){
       return left(Failure("Internet Connection is lost"));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if(!await(checkConnection.isConnection)){
        final session = remoteDataSource.currentUserSession;
        if(session == null){
          return left(Failure("Internet Connection is lost"));
        }
        right(UserModel(email:session.user.email ?? '' , id: session.user.id, name: ""));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}