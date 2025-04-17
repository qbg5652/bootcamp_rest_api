import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/core/snackbar_util.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/home_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/home_tab/home_tab_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabAppBar extends StatelessWidget {
  const HomeTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          final homeTapState = ref.watch(HomeTabViewModelProvider);
          final target =
              homeTapState.addresses
                  .where((e) => e.defaultYn ?? false)
                  .toList();
          final addr = target.isEmpty ? '' : target.first.displayName;
          return Text(addr);
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {
            SnackbarUtil.showSnackBar(context, '검색 서비스를 준비 중입니다.');
          },
          child: Container(
            height: 50,
            width: 50,
            color: Colors.transparent,
            child: Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
