import 'package:flutter/material.dart';

class ProductDetailPicture extends StatelessWidget {
  const ProductDetailPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Image.network(
            'https://picsum.photos/200/300',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
