import 'package:blog_clean_architecture/features/auth/data/model/user_model.dart';
import 'package:blog_clean_architecture/features/blog/domain/entities/blog.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource{
  void uploadBlog(Blog blog);
  Future<UserModel> getBlogs();
}

class BloglocalDataSourceImpl implements BlogLocalDataSource{
  final

  @override
  Future<UserModel> getBlogs() {

  }

  @override
  void uploadBlog(Blog blog) {
    // TODO: implement uploadBlog
  }

}