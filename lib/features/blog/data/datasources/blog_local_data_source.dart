<<<<<<< HEAD
import 'package:blog_clean_architecture/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });

    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();

    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
=======
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
>>>>>>> origin/main
