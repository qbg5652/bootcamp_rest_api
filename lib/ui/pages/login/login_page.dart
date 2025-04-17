import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/snackbar_util.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/home_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/login/login_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/id_text_form_field.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                '안녕하세요!\n아이디와 비밀버호로 로그인해주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              IdTextFormField(controller: idController),
              SizedBox(height: 20),
              PwTextFormField(controller: pwController),
              SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final viewModel = ref.read(loginViewModelProvider);
                        final loginResult = await viewModel.login(
                          username: idController.text,
                          password: pwController.text,
                        );
                        if (loginResult) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                            (route) {
                              return false;
                            },
                          );
                        } else {
                          SnackbarUtil.showSnackBar(
                            context,
                            '아이디와 비밀번호를 확인해주세요.',
                          );
                        }
                      }
                    },
                    child: Text('로그인'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
