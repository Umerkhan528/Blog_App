import 'package:blog_clean_architecture/core/secrets/app_secret.dart';
import 'package:blog_clean_architecture/core/theme/app_theme.dart';
import 'package:blog_clean_architecture/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_clean_architecture/features/auth/data/respository/auth_repository_Implementation.dart';
import 'package:blog_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:blog_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_clean_architecture/features/auth/presentation/pages/login.dart';
import 'package:blog_clean_architecture/features/auth/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabasekey);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => AuthBloc(
        userSignup: UserSignup(
          AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(
              supabase.client,
            ),
          ),
        ),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}
