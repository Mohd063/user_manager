import 'package:manage_me/data/model/user_model.dart';
import 'package:manage_me/data/repositories/api/user_api_repo.dart';

class UserRepository {
  final UserApiRepo _apiRepo;

  UserRepository(this._apiRepo);

  // Add page and limit parameters with default values
  Future<List<UserModel>> getUsersFromApi({int page = 1, int limit = 20}) async {
    try {
      final users = await _apiRepo.fetchUsers(page: page, limit: limit);
      return users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<UserModel?> getUserDetails(int userId) async {
    try {
      return await _apiRepo.fetchUserById(userId);
    } catch (e) {
      return null;
    }
  }
}
