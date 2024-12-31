import 'package:bloc/bloc.dart';
import 'package:blog_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());
  void updateUser(User? user){
    if(user == null){
      emit(AppUserInitial());
    }else{
      emit(AppUserLoggedIn(user: user));
    }
  }
}
