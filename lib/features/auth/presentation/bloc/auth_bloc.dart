import 'package:blog_clean_architecture/core/common/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:blog_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotrue/src/types/user.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecase/current_user.dart';
import '../../domain/usecase/user_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserSignup _userSignup;
  UserLogIn _userLogin;
  CurrentUser _currentUser;
  AppUserCubit _appUserCubit;
  AuthBloc({required UserSignup userSignup, required UserLogIn userLogin,
  required CurrentUser currentUser,
  required AppUserCubit appUserCubit,})
      : _userSignup = userSignup,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);

  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event,
      Emitter<AuthState> emit,
      ) async {
    final res = await _currentUser(NoParams());

    res.fold(
          (l) => emit(AuthFailure(message: l.message,)),
          (r) => AuthSuccess(user:r),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter <AuthState> emit)async {
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

  void _onAuthLogin(AuthLogin event, Emitter <AuthState> emit)async {
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

  void _appUserLoggedIn(User user, Emitter <AuthState> emit){
    if(user != null){
      emit(AuthSuccess(user: user));
      _appUserCubit.updateUser(user);
    }
  }
}
