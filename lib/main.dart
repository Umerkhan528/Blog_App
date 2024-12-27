import 'package:blog_clean_architecture/core/theme/app_theme.dart';
import 'package:blog_clean_architecture/features/auth/presentation/pages/login.dart';
import 'package:blog_clean_architecture/features/auth/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
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
