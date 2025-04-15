import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/validator_util.dart';

class PwTextFormField extends StatelessWidget {
  TextEditingController controller;
  PwTextFormField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: '비밀번호를 입력해주세요.'),
      obscureText: true,
      validator: ValidatorUtil.validatorPassword,
    );
  }
}
