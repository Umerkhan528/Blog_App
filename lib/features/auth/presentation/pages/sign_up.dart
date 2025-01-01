import 'package:blog_clean_architecture/core/theme/app_pallete.dart';
import 'package:blog_clean_architecture/core/utils/show_snack_bar.dart';
import 'package:blog_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_clean_architecture/features/auth/presentation/pages/login.dart';
import 'package:blog_clean_architecture/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_clean_architecture/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog_clean_architecture/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widget/loader.dart';

class SignUpPage extends StatefulWidget {
  static route()=> MaterialPageRoute(builder:(BuildContext context) => SignUpPage() );
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
        child: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is AuthFailure){
      return showSnackBar(context, state.message);
    }
  },
  builder: (context, state) {
    if(state is AuthLoading){
      return const Loader();
    }
    return Form(
          key: _formkey,
          child:
          Column(
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
              AuthGradientButton(
                buttonText: "Sign up",
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim(),
                          ),
                        );
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap:()=> Navigator.pushReplacement(context,LoginPage.route()),
                child: RichText(
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
                    ])),
              )
            ],
          ),
        );
  },
),
      ),
    );
  }
}
