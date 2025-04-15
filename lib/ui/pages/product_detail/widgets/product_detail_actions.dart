import 'package:flutter/material.dart';
import 'package:flutter_expert_rest_api_dangeun/ui/pages/product_write/product_write_page.dart';

class ProductDetailActions extends StatelessWidget {
  const ProductDetailActions({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : 자신의 글이 아니면 보여주지 않기
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
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
                  return ProductWritePage();
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
  }
}
