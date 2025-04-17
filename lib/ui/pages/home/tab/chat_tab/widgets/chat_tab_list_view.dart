import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/date_time_utils.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/chat_room.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/user.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/chat_global_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/chat_detail_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/user_global_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatTabListView extends StatelessWidget {
  const ChatTabListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final chatState = ref.watch(ChatGlobalViewModelPrivider);
        final chatRooms = chatState.chatRooms;
        final user = ref.watch(UserGlobalViewModelProvider);
        if (user == null) {
          return SizedBox();
        }
        return Expanded(
          child: ListView.separated(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              return item(chatRoom, user);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 1);
            },
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        );
      },
    );
  }

  Widget item(ChatRoom room, User user) {
    final displayUser =
        user.id == room.product.user.id ? room.sender : room.product.user;
    final displayDateTime =
        room.messages.isEmpty
            ? ''
            : DateTimeUtils.formatString(room.messages.last.createdAt);
    final message = room.messages.isEmpty ? '' : room.messages.last.content;

    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () {
            ref
                .read(ChatGlobalViewModelPrivider.notifier)
                .fetchChatDetail(room.roomId);
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
                  imgUrl: displayUser.profileImage.url,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${displayUser.nickname}님',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            displayDateTime,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Text(message),
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
