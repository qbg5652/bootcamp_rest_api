import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/home/tab/home_tab/home_tab_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_detail/product_detail_view_model.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_write/product_write_page.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailActions extends StatelessWidget {
  ProductDetailActions(this.productId);

  final int productId;

  @override
  Widget build(BuildContext context) {
    //TODO : 자신의 글이 아니면 보여주지 않기
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(productDetailViewModelProvider(productId));
        final vm = ref.read(productDetailViewModelProvider(productId).notifier);

        final user = ref.read(UserGlobalViewModelProvider);
        if (state?.user.id != user?.id) {
          return SizedBox();
        }
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                final result = await vm.delete();
                if (result == true) {
                  ref.read(HomeTabViewModelProvider.notifier).fetchProducts();
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.delete),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductWritePage(state);
                    },
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.edit),
              ),
            ),
          ],
        );
      },
    );
  }
}
