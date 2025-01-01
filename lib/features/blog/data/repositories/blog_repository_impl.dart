import 'dart:io';
import 'package:blog_clean_architecture/core/errors/failure.dart';
import 'package:blog_clean_architecture/core/errors/server_exception.dart';
import 'package:blog_clean_architecture/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_clean_architecture/features/blog/data/models/blog_model.dart';
import 'package:blog_clean_architecture/features/blog/domain/entities/blog.dart';
import 'package:blog_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/networks/check_internet.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  CheckConnection checkConnection;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
      this.checkConnection,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if(! await (checkConnection.isConnection)){
        return left(Failure("Internet Connection is lost"));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on  AuthException catch (e) {
      return left(Failure("Internet Connected is lost!"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if(! await (checkConnection.isConnection)){
        return left(Failure("Data will be available after the internet connection is secured!"));
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on SocketException catch (e) {
      return left(Failure("Data will be available after the internet connection is secured!"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
