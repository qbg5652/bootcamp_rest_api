import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/home_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_write/product_write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFlatingActionButton extends StatelessWidget {
  const HomeFlatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModelProvider);
        if (currentIndex != 0) {
          return SizedBox();
        }

        return FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProductWritePage(null);
                },
              ),
            );
          },
          label: Text(
            '상품목록',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Theme.of(context).highlightColor,
          foregroundColor: Colors.white,
        );
      },
    );
  }
}
