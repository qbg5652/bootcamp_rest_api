import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/image_picker_helper.dart';
import 'package:flutter_expert_rest_api_dangeun/core/snackbar_util.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/join/join_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/welcome/welcome_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/id_text_form_field.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/nickname_text_form_field.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends ConsumerStatefulWidget {
  const JoinPage(this.address);

  final String address;

  @override
  ConsumerState<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends ConsumerState<JoinPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final nicknameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  void onImageUpload() async {
    print('onImageUpload 메서드');
    final result = await ImagePickerHelper.pickImage();
    if (result != null) {
      final viewModel = ref.read(JoinViewModelProvider.notifier);
      viewModel.imageUpload(
        fileName: result.finaname,
        mimeType: result.mimetype,
        bytes: result.bytes,
      );
    }
  }

  void onJoin() async {
    print('onJoin 메서드');
    if (formKey.currentState?.validate() ?? false) {
      final viewModel = ref.read(JoinViewModelProvider.notifier);

      final validateResult = await viewModel.validateName(
        userName: idController.text,
        nickName: nicknameController.text,
      );

      if (validateResult != null) {
        SnackbarUtil.showSnackBar(context, validateResult);
        return;
      }

      final result = await viewModel.join(
        userName: idController.text,
        password: pwController.text,
        nickName: nicknameController.text,
        addressFulName: widget.address,
      );
      if (result) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
          (route) {
            return false;
          },
        );
      } else {
        SnackbarUtil.showSnackBar(context, '회원가입에 실패했습니다. 다시 확인해주세요.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileModel = ref.watch(JoinViewModelProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Text(
                '안녕하세요!\n아이디와 비밀번호로 가입해주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: onImageUpload,
                child: Align(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child:
                        fileModel != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                fileModel.url,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person, size: 30),
                                Text('프로필 사진', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              IdTextFormField(controller: idController),
              SizedBox(height: 20),
              PwTextFormField(controller: pwController),
              SizedBox(height: 20),
              NicknameTextFormField(controller: nicknameController),
              SizedBox(height: 20),
              ElevatedButton(onPressed: onJoin, child: Text('회원가입')),
            ],
          ),
        ),
      ),
    );
  }
}
