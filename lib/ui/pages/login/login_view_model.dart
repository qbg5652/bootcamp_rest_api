import 'package:flutter_expert_rest_api_dangeun/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel {
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final userRepository = UserRepository();
    return await userRepository.login(username: username, password: password);
  }
}

final loginViewModelProvider = Provider.autoDispose((ref) {
  return LoginViewModel();
});
