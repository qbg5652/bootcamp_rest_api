import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/home_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/chat_tab/chat_tab.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/home_tab/home_tab.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/mytab/my_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeIndexedStack extends StatelessWidget {
  const HomeIndexedStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModelProvider);
        return IndexedStack(
          index: currentIndex,
          children: [HomeTab(), ChatTab(), MyTab()],
        );
      },
    );
  }
}
