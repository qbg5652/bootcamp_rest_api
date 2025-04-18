import 'package:flutter_expert_rest_api_dangeun/data/model/file_model.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/product.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/product_category.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/file_repository.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/product_category_repository.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductWriteState {
  final List<FileModel> imageFiles;
  final List<ProductCategory> categories;
  final ProductCategory? selectedCategory;

  ProductWriteState({
    required this.imageFiles,
    required this.categories,
    required this.selectedCategory,
  });

  ProductWriteState copyWith({
    List<FileModel>? imageFiles,
    List<ProductCategory>? categories,
    ProductCategory? selectedCategory,
  }) {
    return ProductWriteState(
      imageFiles: imageFiles ?? this.imageFiles,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class ProductWriteViewModel
    extends AutoDisposeFamilyNotifier<ProductWriteState, Product?> {
  @override
  ProductWriteState build(Product? arg) {
    return ProductWriteState(
      imageFiles: arg?.imageFiles ?? [],
      categories: [],
      selectedCategory: arg?.category ?? null,
    );
  }

  final categoryRepository = ProductCategoryRepository();
  final fileRepository = FileRepository();
  final productRepository = ProductRepository();
  // 카테고리 리스트 서버에서 가져오는 메서드
  Future<void> fetchCategories() async {
    final categories = await categoryRepository.getCategoryList();
    if (categories != null) {
      state = state.copyWith(categories: categories);
    }
  }

  //이미지 업로드
  Future<void> uploadImage({
    required String fileName,
    required String mimeType,
    required List<int> bytes,
  }) async {
    final result = await fileRepository.upload(
      bytes: bytes,
      filename: fileName,
      mimeType: mimeType,
    );
    if (result != null) {
      state = state.copyWith(imageFiles: [...state.imageFiles, result]);
    }
  }

  //상품 수정하거나 생성
  Future<bool?> upload({
    required String title,
    required String content,
    required int price,
  }) async {
    if (state.imageFiles.isEmpty) {
      return null;
    }

    if (state.selectedCategory == null) {
      return null;
    }

    if (arg != null) {
      //수정
      final result = await productRepository.update(
        id: arg!.id,
        title: title,
        content: content,
        imageFileOdList: state.imageFiles.map((e) => e.id).toList(),
        categoryId: state.selectedCategory!.id,
        price: price,
      );
      return result;
    } else {
      //생성
      final result = await productRepository.create(
        title: title,
        content: content,
        imageFileOdList: state.imageFiles.map((e) => e.id).toList(),
        categoryId: state.selectedCategory!.id,
        price: price,
      );
      return result != null;
    }
  }

  //카테고리 선택했을 때 수행되는 메서드
  void onCategorySelected(String category) {
    final target = state.categories.where((e) => e.category == category);
    if (target.isEmpty) {
      return;
    }
    final selectedCategory = target.first;
    state = state.copyWith(selectedCategory: selectedCategory);
  }
}

final ProductWriteViewModelProvider = NotifierProvider.autoDispose
    .family<ProductWriteViewModel, ProductWriteState, Product?>(() {
      return ProductWriteViewModel();
    });
