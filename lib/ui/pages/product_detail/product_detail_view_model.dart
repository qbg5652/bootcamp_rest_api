import 'package:flutter_expert_rest_api_dangeun/data/model/product.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailViewModel extends AutoDisposeFamilyNotifier<Product?, int> {
  @override
  Product? build(int arg) {
    fetchDetail();
    return null;
  }

  final productRepository = ProductRepository();

  //상품상세 불러오기
  Future<void> fetchDetail() async {
    state = await productRepository.fetchDetail(arg);
  }
  //좋아요

  Future<bool> like() async {
    final newLike = await productRepository.like(arg);
    if (newLike == null) {
      return false;
    }
    state = state?.copyWith(myLike: newLike);
    return true;
  }

  //삭제
  Future<bool?> delete() async {
    return await productRepository.delete(arg);
  }

  // Future<void> createChat() async {
  //   // 나중에 구현
  // }
}

final productDetailViewModelProvider = NotifierProvider.autoDispose
    .family<ProductDetailViewModel, Product?, int>(() {
      return ProductDetailViewModel();
    });
