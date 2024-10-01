import 'package:flirty/features/home/services/all_users_service.dart';
import 'package:flirty/models/user.dart';
import 'package:flirty/utils/dio/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User StateNotifier
class UserNotifier extends StateNotifier<List<User>> {
  final UserService userService;

  UserNotifier(this.userService) : super([]);

  Future<void> loadUsers() async {
    try {
      final users = await userService.fetchUsers();
      state = users;
    } catch (e) {
      print(e);
    }
  }
}

// Create a Provider for the UserService
final userServiceProvider = Provider<UserService>((ref) {
  return UserService(DioClient());
});

// Create a StateNotifierProvider for the UserNotifier
final allUsersProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  final userService = ref.watch(userServiceProvider);
  return UserNotifier(userService)..loadUsers();
});
