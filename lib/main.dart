import 'package:blog_clean_architecture/core/secrets/app_secret.dart';
import 'package:blog_clean_architecture/core/theme/app_theme.dart';
import 'package:blog_clean_architecture/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  final supabase = Supabase.initialize(url: AppSecret.supabaseUrl, anonKey: AppSecret.supabasekey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
