import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/validator_util.dart';

class IdTextFormField extends StatelessWidget {
  TextEditingController controller;
  IdTextFormField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: '아이디를 입력해주세요.'),
      validator: ValidatorUtil.validatorId,
    );
  }
}
