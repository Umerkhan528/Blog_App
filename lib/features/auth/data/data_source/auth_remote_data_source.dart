import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/errors/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {

  Future<String> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> signUpWithEmailPassword({required String email, required String password, required String name}) async{
  try{
    final res = await supabaseClient.auth.signUp(password: password,email: email,data: {
      'name': name,
    });
    if(res.user == null){
      throw ServerException("user is null");
    }
    return res.user!.id;
  }catch(e){
    throw ServerException(e.toString());
  }
  }

  @override
  Future<String> loginWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }
  
}