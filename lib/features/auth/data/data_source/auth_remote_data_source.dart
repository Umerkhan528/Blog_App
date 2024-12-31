import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/errors/server_exception.dart';
import 'package:blog_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {

  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> signUpWithEmailPassword({required String email, required String password, required String name}) async{
  try{
    final res = await supabaseClient.auth.signUp(password: password,email: email,data: {
      'name': name,
    });
    if(res.user == null){
      throw ServerException("user is null");
    }
    return UserModel.fromJson(res.user!.toJson());
  }catch(e){
    throw ServerException(e.toString());
  }
  }

  @override
  Future<UserModel> loginWithEmailPassword({required String email, required String password}) async{
    try{
      final res = await supabaseClient.auth.signInWithPassword(password: password,email: email,);
      if(res.user == null){
        throw ServerException("user is null");
      }
      return UserModel.fromJson(res.user!.toJson());
    }catch(e){
      throw ServerException(e.toString());
    }
  }
  
}