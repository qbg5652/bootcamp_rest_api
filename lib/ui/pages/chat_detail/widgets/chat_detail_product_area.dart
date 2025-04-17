import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/date_time_utils.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/chat_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetailProductArea extends StatelessWidget {
  const ChatDetailProductArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey[300] as Color),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(ChatGlobalViewModelPrivider);
            if (state.chatRoom == null) {
              return SizedBox();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.chatRoom!.product.title),
                SizedBox(height: 2),
                Text(DateTimeUtils.formatString(state.chatRoom!.createdAt)),
              ],
            );
          },
        ),
      ),
    );
  }
}
