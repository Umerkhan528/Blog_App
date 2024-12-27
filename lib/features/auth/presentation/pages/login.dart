import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign in.",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(controller: emailController, hintText: "Email"),
              const SizedBox(height: 15),
              AuthField(controller: passwordController, hintText: "Password"),
              const SizedBox(height: 20),
              const AuthGradientButton(buttonText: "Sign in"),
              const SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      text: "Don't have an account",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                    TextSpan(
                        text: " Sign Up",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: AppPallete.gradient2,
                                fontWeight: FontWeight.bold))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
