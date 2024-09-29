import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class AuthNotifier extends StateNotifier<Map<String, dynamic>> {
  AuthNotifier()
      : super({
          'accessToken': null,
          'userId': null,
          'isRegistrationStarted': false,
          'currentStep': 0,
        }) {
    loadUser();
  }

  Future<void> login(String accessToken, String userId) async {
    state['accessToken'] = accessToken;
    state['userId'] = userId;
    await secureStorage.write(key: 'accessToken', value: accessToken);
    await secureStorage.write(key: 'userId', value: userId);
  }

  Future<void> logout() async {
    state['accessToken'] = null;
    state['userId'] = null;
    state['isRegistrationStarted'] = false;
    state['currentStep'] = 0;
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'userId');
  }

  Future<void> loadUser() async {
    final accessToken = await secureStorage.read(key: 'accessToken');
    final userId = await secureStorage.read(key: 'userId');
    final isRegistrationStarted =
        await secureStorage.read(key: 'isRegistrationStarted');
    final currentStep = await secureStorage.read(key: 'currentStep');

    state['accessToken'] = accessToken;
    state['userId'] = userId;
    state['isRegistrationStarted'] = isRegistrationStarted == 'true';
    state['currentStep'] = currentStep != null ? int.parse(currentStep) : 0;
  }

  Future<void> startRegistration(String userId) async {
    state['userId'] = userId;
    state['isRegistrationStarted'] = true;
    state['currentStep'] = 1; // Start at step 1
    await secureStorage.write(key: 'isRegistrationStarted', value: 'true');
    await secureStorage.write(key: 'userId', value: userId);
    await secureStorage.write(key: 'currentStep', value: '1');
  }

  Future<void> advanceRegistrationStep(int currentStep) async {
    if (state['isRegistrationStarted'] == true) {
      state['currentStep'] = currentStep;
      await secureStorage.write(
        key: 'currentStep',
        value: state['currentStep'].toString(),
      );
    }
  }

  Future<void> completeRegistration() async {
    state['isRegistrationStarted'] = false;
    state['currentStep'] = 0;
    state['userId'] = null;
    await secureStorage.delete(key: 'isRegistrationStarted');
    await secureStorage.delete(key: 'currentStep');
    await secureStorage.delete(key: 'userId');
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, Map<String, dynamic>>((ref) {
  return AuthNotifier();
});
