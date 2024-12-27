import 'package:blog_clean_architecture/core/theme/app_pallete.dart';
import 'package:blog_clean_architecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_clean_architecture/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
                "Sign up.",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(controller: nameController, hintText: "Name"),
              const SizedBox(height: 15),
              AuthField(controller: emailController, hintText: "Email"),
              const SizedBox(height: 15),
              AuthField(controller: passwordController, hintText: "Password"),
              const SizedBox(height: 20),
              const AuthGradientButton(buttonText: "Sign up"),
              const SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      text: "Already have an account",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                    TextSpan(
                        text: " Sign In",
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
