import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/product.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_write/product_write_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCategoryBox extends StatelessWidget {
  ProductCategoryBox(this.product);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(ProductWriteViewModelProvider(product));
        final vm = ref.read(ProductWriteViewModelProvider(product).notifier);

        return Align(
          alignment: Alignment.centerLeft,
          child: PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: vm.onCategorySelected,
            itemBuilder: (context) {
              final categories = state.categories;
              return categories.map((e) {
                return categoryItem(
                  e.category,
                  e.id == state.selectedCategory?.id,
                );
              }).toList();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                state.selectedCategory?.category ?? '카테고리 선택',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        );
      },
    );
  }

  PopupMenuItem<String> categoryItem(String text, bool isSelected) {
    return PopupMenuItem<String>(
      value: text,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : null,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
