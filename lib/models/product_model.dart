import 'package:clothing_ecommerce/data/app_urls.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.quantity,
  });
  late final int id;
  late final String name;
  late final String description;
  late final int price;
  late final String image;
  late final int category;
  late final int quantity;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = AppUrl.baseUrl + json['image'];
    category = json['category'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['category'] = category;
    data['quantity'] = quantity;
    return data;
  }
}
