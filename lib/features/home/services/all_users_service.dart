import 'package:flirty/models/user.dart';
import 'package:flirty/routes/api_routes.dart';
import 'package:flirty/utils/dio/dio_client.dart';

class UserService {
  final DioClient dio;

  UserService(this.dio);

  Future<List<User>> fetchUsers() async {
    try {
      final response = await dio.get(ApiRoutes.getAllUsers);
      if (response.statusCode == 200) {
        List<User> users = (response.data['users'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
