import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/errors/server_exception.dart';
import 'package:blog_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  SupabaseClient supabaseClient;

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final res = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        'name': name,
      });
      if (res.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final res = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (res.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
