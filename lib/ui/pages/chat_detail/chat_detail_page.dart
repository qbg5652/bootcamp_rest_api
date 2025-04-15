import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/widgets/chat_detail_bottom_sheet.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/widgets/chat_detail_list_view.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/chat_detail/widgets/chat_detail_product_area.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('오상구'), centerTitle: true),
        body: Column(children: [ChatDetailProductArea(), ChatDetailListView()]),
        bottomSheet: ChatDetailBottomSheet(
          MediaQuery.of(context).padding.bottom,
        ),
      ),
    );
  }
}
