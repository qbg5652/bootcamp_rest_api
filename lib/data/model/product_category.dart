class ProductCategory {
  int id;
  String category;

  ProductCategory({required this.id, required this.category});

  ProductCategory.fromJson(Map<String, dynamic> map)
    : this(id: map['id'], category: map['category']);

  Map<String, dynamic> toJson() {
    return {'id': id, 'category': category};
  }
}
