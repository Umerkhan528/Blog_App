part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});
}

final class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess({required this.message});
}