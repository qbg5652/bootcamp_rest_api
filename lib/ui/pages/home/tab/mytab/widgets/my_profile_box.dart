import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/snackbar_util.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/user_global_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfileBox extends StatelessWidget {
  const MyProfileBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(UserGlobalViewModelProvider);
        return Row(
          children: [
            user == null
                ? SizedBox()
                : UserProfileImage(
                  dimension: 50,
                  imgUrl: user.profileImage.url,
                ),
            SizedBox(width: 10),
            Expanded(
              child:
                  user == null
                      ? SizedBox()
                      : Text(
                        user.nickname,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
            GestureDetector(
              onTap: () {
                SnackbarUtil.showSnackBar(context, '프로필 수정 기능 준비중입니다.');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(color: Colors.grey),
                child: Text(
                  '프로필 수정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
