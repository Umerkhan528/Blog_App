import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/errors/server_exception.dart';
import 'package:blog_clean_architecture/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> loginWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({required String email, required String password, required String name}) async{
    try{
      final user = await remoteDataSource.signUpWithEmailPassword(email: email, password: password, name: name);
      return right(user);
    }on ServerException catch(e){
     return left(Failure( e.message));
    }
  }
  
}