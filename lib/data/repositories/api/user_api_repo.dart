import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:manage_me/data/model/user_model.dart';

class UserApiRepo {
  final String baseUrl = 'https://dummyjson.com/users';

  // ✅ Fetch paginated users
  Future<List<UserModel>> fetchUsers({int limit = 20, int page = 1}) async {
    final skip = (page - 1) * limit;
    final response = await http.get(Uri.parse('$baseUrl?limit=$limit&skip=$skip'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> usersList = jsonData['users'];
      return usersList.map((userJson) => UserModel.fromJson(userJson)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // ✅ Fetch user by ID
  Future<UserModel> fetchUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
