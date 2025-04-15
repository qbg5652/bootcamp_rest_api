import 'package:flutter/material.dart';

class ProductCategoryBox extends StatelessWidget {
  const ProductCategoryBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton<String>(
        position: PopupMenuPosition.under,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onSelected: (value) {
          print(value);
        },
        itemBuilder: (context) {
          return [
            categoryItem('디지털 가전', true),
            categoryItem('생활용품', false),
            categoryItem('도서', false),
          ];
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '카테고리 선택',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
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
