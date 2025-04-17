import 'dart:typed_data';

import 'package:flutter_expert_rest_api_dangeun/data/model/file_model.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/file_repository.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinViewModel extends AutoDisposeNotifier<FileModel?> {
  @override
  build() {
    return null;
  }

  final fileRepository = FileRepository();
  final userRepository = UserRepository();

  void imageUpload({
    required String fileName,
    required String mimeType,
    required Uint8List bytes,
  }) async {
    final fileModel = await fileRepository.upload(
      bytes: bytes,
      filename: fileName,
      mimeType: mimeType,
    );
    state = fileModel;
  }

  Future<bool> join({
    required String userName,
    required String password,
    required String nickName,
    required String addressFulName,
  }) async {
    if (state == null) {
      return false;
    }
    return await userRepository.join(
      username: userName,
      nickname: nickName,
      password: password,
      addressFullName: addressFulName,
      profileImageId: state!.id,
    );
  }

  Future<String?> validateName({
    required String userName,
    required String nickName,
  }) async {
    final idResult = await userRepository.usernameCk(userName);
    if (!idResult) {
      return "사용할 수 없는 아이디입니다.";
    }
    final nickResult = await userRepository.nicknameCk(nickName);
    if (!nickResult) {
      return "사용할 수 없는 닉네임 입니다.";
    }

    return null;
  }
}

final JoinViewModelProvider =
    NotifierProvider.autoDispose<JoinViewModel, FileModel?>(() {
      return JoinViewModel();
    });
