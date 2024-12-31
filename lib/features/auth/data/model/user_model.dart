import 'dart:convert';

import 'package:blog_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:blog_clean_architecture/features/auth/domain/usecase/user_signup.dart';

class UserModel extends User {
  UserModel({required super.email, required super.id, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}

class UserSignupParams {}