import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/home_tab/widgets/product_list_item.dart';

class HomeTabListView extends StatelessWidget {
  const HomeTabListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemBuilder: (context, index) {
          return ProductListItem();
        },
        separatorBuilder: (context, index) {
          return Divider(height: 20);
        },
        itemCount: 10,
      ),
    );
  }
}
