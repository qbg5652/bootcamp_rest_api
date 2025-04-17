import 'package:flutter_expert_rest_api_dangeun/data/model/file_model.dart';

class User {
  int id;
  String username;
  String nickname;
  FileModel profileImage;

  User({
    required this.id,
    required this.username,
    required this.nickname,
    required this.profileImage,
  });

  User.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        username: map['username'],
        profileImage: FileModel.fromJson(map['profileImage']),
        nickname: map['nickname'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'nickname': nickname,
      'profileImage': profileImage.toJson(),
    };
  }
}
