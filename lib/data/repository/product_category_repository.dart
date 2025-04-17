import 'package:flutter_expert_rest_api_dangeun/data/model/product_category.dart';
import 'package:flutter_expert_rest_api_dangeun/data/repository/base_remote_repository.dart';

class ProductCategoryRepository extends BaseRemoteRepository {
  Future<List<ProductCategory>?> getCategoryList() async {
    final response = await client.get('/api/product/category');
    if (response.statusCode == 200) {
      final content = response.data['content'];
      List.from(content).map((e) => ProductCategory.fromJson(e)).toList();
    }
    return null;
  }
}
