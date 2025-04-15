import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/chat_tab/widgets/chat_tab_app_bar.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/chat_tab/widgets/chat_tab_list_view.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(children: [ChatTabAppBar(), ChatTabListView()]),
    );
  }
}
