import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manage_me/data/model/post_model.dart';

class PostApiRepo {
  final String baseUrl = "https://dummyjson.com";

  Future<List<PostModel>> fetchPostsByUser(int userId) async {
    final url = Uri.parse('$baseUrl/posts'); // fetch all posts first
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> postsJson = data['posts'] ?? [];

      // Filter posts by userId (client-side filtering)
      final filteredPosts = postsJson
          .where((postJson) => postJson['userId'] == userId)
          .toList();

      print("📡 API returned ${filteredPosts.length} posts for user $userId");

      return filteredPosts
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
    } else {
      print("❌ API Error: ${response.statusCode} - ${response.reasonPhrase}");
      throw Exception('Failed to load posts for user $userId');
    }
  }
}
