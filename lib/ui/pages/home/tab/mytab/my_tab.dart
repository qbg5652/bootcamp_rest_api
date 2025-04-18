import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/snackbar_util.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/mytab/widgets/my_profile_box.dart';

class MyTab extends StatelessWidget {
  const MyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          MyProfileBox(),
          SizedBox(height: 8),
          label('나의 거래'),
          item(text: '관심목록', icon: CupertinoIcons.heart),
          item(text: '판매내역', icon: CupertinoIcons.square_list),
          item(text: '구매내역', icon: CupertinoIcons.bag),
          item(text: '중고거래 가계부', icon: CupertinoIcons.book),
          Divider(),
          label('나의 소식'),
          item(text: '이벤트', icon: CupertinoIcons.gift),
          item(text: '공지사항', icon: CupertinoIcons.news),
          Divider(),
          label('기타'),
          item(text: '내 동네 설정', icon: Icons.location_on_outlined),
          item(text: '동네 인증하기', icon: Icons.gps_not_fixed),
          Divider(),
          item(text: '자주 묻는 질문'),
          item(text: '약관 및 정책'),
        ],
      ),
    );
  }

  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget item({required String text, IconData? icon}) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            SnackbarUtil.showSnackBar(context, '준비 중입니다.');
          },
          child: Container(
            height: 40,
            color: Colors.transparent,
            child: Row(
              children: [
                if (icon != null) ...[Icon(icon), SizedBox(width: 8)],
                Text(text, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }
}
