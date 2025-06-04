import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manage_me/data/model/todo_model.dart';

class TodoApiRepo {
  final String baseUrl = "https://dummyjson.com";

  Future<List<TodoModel>> fetchTodosByUser(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/todos/user/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> todosJson = data['todos'];
      return todosJson.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load todos for user $userId");
    }
  }
}
