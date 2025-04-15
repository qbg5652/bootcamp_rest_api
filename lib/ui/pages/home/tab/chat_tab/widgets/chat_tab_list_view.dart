import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/chat_detail_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/user_profile_image.dart';

class ChatTabListView extends StatelessWidget {
  const ChatTabListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return item();
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1);
        },
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Widget item() {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatDetailPage();
                },
              ),
            );
          },
          child: Container(
            height: 80,
            color: Colors.transparent,
            child: Row(
              children: [
                UserProfileImage(
                  dimension: 50,
                  imgUrl: 'https://picsum.photos/200/300',
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '멍멍이님',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '6분전',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Text('네고 가능한가요?'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
