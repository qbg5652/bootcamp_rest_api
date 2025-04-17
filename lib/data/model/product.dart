import 'package:flutter/foundation.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/address.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/file_model.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/product_category.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/user.dart';

class Product {
  int id;
  String title;
  String content;
  List<FileModel> imageFiles;
  User user;
  Address address;
  ProductCategory category;
  int price;
  int likeCnt;
  bool myLike;
  DateTime updatedAt;
  DateTime createdAt;

  Product({
    required this.id,
    required this.title,
    required this.content,
    required this.imageFiles,
    required this.user,
    required this.address,
    required this.category,
    required this.price,
    required this.likeCnt,
    required this.myLike,
    required this.createdAt,
    required this.updatedAt,
  });

  Product.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        imageFiles:
            List.from(
              map['imageFiles'],
            ).map((e) => FileModel.fromJson(e)).toList(),
        user: User.fromJson(map['user']),
        address: Address.fromJson(map['address']),
        category: ProductCategory.fromJson(map['category']),
        price: map['price'],
        likeCnt: map['likeCnt'],
        myLike: map['myLike'],
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageFiles': imageFiles.map((e) => e.toJson()).toList(),
      'user': user.toJson(),
      'address': address.toJson(),
      'category': category.toJson(),
      'price': price,
      'likeCnt': likeCnt,
      'myLike': myLike,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Product copyWith({
    int? id,
    String? title,
    String? content,
    List<FileModel>? imageFiles,
    User? user,
    Address? address,
    ProductCategory? category,
    int? price,
    int? likeCnt,
    bool? myLike,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageFiles: imageFiles ?? this.imageFiles,
      user: user ?? this.user,
      address: address ?? this.address,
      category: category ?? this.category,
      price: price ?? this.price,
      likeCnt: likeCnt ?? this.likeCnt,
      myLike: myLike ?? this.myLike,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
