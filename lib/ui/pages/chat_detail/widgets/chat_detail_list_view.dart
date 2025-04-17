import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/chat_global_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/widgets/chat_detail_receive_item.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/widgets/chat_detail_send_item.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetailListView extends StatelessWidget {
  final children = [
    ChatDetailReceiveItem(
      imgUrl: 'https://picsum.photos/200/300',
      showProfile: true,
      content: '안녕하세요',
      dateTime: DateTime.now(),
    ),
    ChatDetailReceiveItem(
      imgUrl: 'https://picsum.photos/200/300',
      showProfile: false,
      content: '네고가능한가요',
      dateTime: DateTime.now(),
    ),
    ChatDetailSendItem(content: '네, 안녕하세요', dateTime: DateTime.now()),
    ChatDetailSendItem(content: '네고 안돼요', dateTime: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final chatRoom = ref.watch(ChatGlobalViewModelPrivider).chatRoom;
        if (chatRoom == null) {
          return SizedBox();
        }

        final messages = chatRoom.messages;
        final user = ref.watch(UserGlobalViewModelProvider)!;

        return Expanded(
          child: ListView.separated(
            itemCount: messages.length,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            separatorBuilder: (context, index) {
              return SizedBox(height: 4);
            },
            itemBuilder: (context, index) {
              final message = messages[index];
              final msgSender =
                  message.messageType == 'SENDER_TO_PRODUCT_OWNER'
                      ? chatRoom.sender
                      : chatRoom.product.user;

              if (user.id == msgSender) {
                return ChatDetailSendItem(
                  content: message.content,
                  dateTime: message.createdAt,
                );
              }
              bool showProfile = true;
              if (index > 0) {
                final preMessage = messages[index - 1];
                showProfile = preMessage.messageType != message.messageType;
              }

              return ChatDetailReceiveItem(
                imgUrl: msgSender.profileImage.url,
                showProfile: showProfile,
                content: message.content,
                dateTime: message.createdAt,
              );
            },
          ),
        );
      },
    );
  }
}
