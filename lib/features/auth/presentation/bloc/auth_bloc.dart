import 'package:blog_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserSignup _userSignup;

  AuthBloc({required UserSignup userSignup})
      : _userSignup = userSignup,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final user = await _userSignup(UserSignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));
      user.fold(
          (f) => emit(AuthFailure(message: f.message)),
          (r) => emit(
                AuthSuccess(message: r),
              ));
    });
  }
}
