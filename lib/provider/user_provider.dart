import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<Map<String, dynamic>?> {
  UserProvider() : super(null);

  // Initialize user data
  void initializeUser(Map<String, dynamic> user) {
    state = user; // Set the initial user data
  }

  // Update user data
  void updateUser(Map<String, dynamic> updatedUser) {
    if (state != null) {
      state = {
        ...state!,
        ...updatedUser
      }; // Merge the updated user data with existing data
    }
  }

  // Set online status
  void setOnlineStatus(bool isOnline) {
    if (state != null) {
      state = {
        ...state!,
        'isOnline': isOnline, // Update the online status
      };
    }
  }

  // Remove user data
  void removeUser() {
    state = null; // Reset the state to null, effectively removing the user
  }
}

// Create a provider for the UserProvider
final userProvider =
    StateNotifierProvider<UserProvider, Map<String, dynamic>?>((ref) {
  return UserProvider();
});
