import 'package:flutter/cupertino.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/user.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserGlobalViewModel extends Notifier<User?> {
  @override
  User? build() {
    fetchUserInfo();
    return null;
  }

  final userRepository = UserRepository();

  Future<void> fetchUserInfo() async {
    final user = await userRepository.myInfo();
    state = user;
  }
}

final UserGlobalViewModelProvider =
    NotifierProvider<UserGlobalViewModel, User?>(() {
      return UserGlobalViewModel();
    });
