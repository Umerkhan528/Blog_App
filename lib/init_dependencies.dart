import 'package:blog_clean_architecture/core/secrets/app_secret.dart';
import 'package:blog_clean_architecture/core/usecases/usecase.dart';
import 'package:blog_clean_architecture/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_clean_architecture/features/auth/data/respository/auth_repository_Implementation.dart';
import 'package:blog_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabasekey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<Usecase>(
    () => UserSignup(
      serviceLocator(),
    ),
  );
}
