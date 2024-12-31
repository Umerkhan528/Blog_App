import 'package:blog_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecase/user_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserSignup _userSignup;
  UserLogIn _userLogin;

  AuthBloc({required UserSignup userSignup, required UserLogIn userLogin})
      : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);

  }

  Future<void> _onAuthSignUp(AuthSignUp event, Emitter <AuthState> emit)async {
    emit(AuthLoading());
    final user = await _userSignup(UserSignupParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    user.fold(
            (f) => emit(AuthFailure(message: f.message)),
            (user) => emit(
          AuthSuccess(user: user),
        ));
  }

  Future<void> _onAuthLogin(AuthLogin event, Emitter <AuthState> emit)async {
    emit(AuthLoading());
    final user = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));
    user.fold(
            (f) => emit(AuthFailure(message: f.message)),
            (user) => emit(
          AuthSuccess(user: user),
        ));
  }
}
