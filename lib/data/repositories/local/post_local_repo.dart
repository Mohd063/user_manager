import 'package:manage_me/data/db/db_helper.dart';
import 'package:manage_me/data/model/post_model.dart';

class PostLocalRepo {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> insertPost(PostModel post) {
    return dbHelper.insertPost(post);
  }

  Future<List<PostModel>> fetchPostsByUser(int userId) {
     print("Fetched local posts count: ${dbHelper.fetchPostsByUser(userId).toString()}");
    return dbHelper.fetchPostsByUser(userId);
  }

  Future<void> deletePost(int id) {
    return dbHelper.deletePost(id);
  }

  Future<void> updatePost(PostModel post) {
    return dbHelper.updatePost(post);
  }
}
