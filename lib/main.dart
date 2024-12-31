import 'package:blog_clean_architecture/core/secrets/app_secret.dart';
import 'package:blog_clean_architecture/core/theme/app_theme.dart';
import 'package:blog_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_clean_architecture/features/auth/presentation/pages/sign_up.dart';
import 'package:blog_clean_architecture/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<AuthBloc>(),
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
