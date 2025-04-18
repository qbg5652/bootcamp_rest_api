import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/address_search/address_search_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/chat_detail_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/home_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/join/join_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/login/login_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_detail/product_detail_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_write/product_write_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Spacer(),
                Image.asset('assets/welcome.webp', height: 250),
                Text(
                  '당신 근처의 마켓',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '동네라서 가능한 모든 것\n지금 내 동네를 선택하고 시작해보세요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AddressSearchPage();
                        },
                      ),
                    );
                  },
                  child: Text('시작하기'),
                ),
                GestureDetector(
                  onTap: () {
                    print('로그인 텍스트 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      '이미 계정이 있나요? 로그인',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) {
      //           return JoinPage('dd');
      //         },
      //       ),
      //     );
      //   },
      //   child: Icon(Icons.plus_one),
      // ),
    );
  }
}
