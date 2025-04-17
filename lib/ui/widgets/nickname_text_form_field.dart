import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/validator_util.dart';

class NicknameTextFormField extends StatelessWidget {
  TextEditingController controller;
  NicknameTextFormField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: '닉네임을 입력해주세요.'),
      // obscureText: true,
      validator: ValidatorUtil.validatorNickname,
    );
  }
}
