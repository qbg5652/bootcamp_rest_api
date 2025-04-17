import 'package:flutter_expert_rest_api_dangeun/data/model/address.dart';
import 'package:flutter_expert_rest_api_dangeun/data/model/file_model.dart';

class ProductSummary {
  int id;
  String title;
  FileModel thumbnail;
  Address address;
  int price;
  int likeCnt;
  DateTime updatedAt;
  DateTime createdAt;

  ProductSummary({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.address,
    required this.price,
    required this.likeCnt,
    required this.updatedAt,
    required this.createdAt,
  });

  ProductSummary.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        title: map['title'],
        thumbnail: FileModel.fromJson(map['thumbnail']),
        address: Address.fromJson(map['address']),
        price: map['price'],
        likeCnt: map['likeCnt'],
        updatedAt: DateTime.parse(map['updatedAt']),
        createdAt: DateTime.parse(map['createdAt']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail.toJson(),
      'address': address.toJson(),
      'price': price,
      'likeCnt': likeCnt,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
