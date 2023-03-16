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
    required this.size,
    required this.color,
  });
  late final int id;
  late final String name;
  late final String description;
  late final int price;
  late final String image;
  late final int category;
  late final int quantity;
  late final List<SizeData> size;
  late final List<String> sizeList;
  late final List<ColorData> color;
  late final List<String> colorList;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = AppUrl.baseUrl + json['image'];
    category = json['category'];
    quantity = json['quantity'];
    color = List.from(json['color']).map((e) => ColorData.fromJson(e)).toList();
    colorList =
        List.from(json['color']).map((e) => e["color"].toString()).toList();
    size = List.from(json['size']).map((e) => SizeData.fromJson(e)).toList();
    sizeList =
        List.from(json['size']).map((e) => e["title"].toString()).toList();
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
    data['size'] = size.map((e) => e.toJson()).toList();
    data['color'] = color.map((e) => e.toJson()).toList();
    return data;
  }
}

class SizeData {
  SizeData({
    required this.id,
    required this.title,
  });
  late final int id;
  late final String title;

  SizeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class ColorData {
  ColorData({
    required this.id,
    required this.color,
  });
  late final int id;
  late final String color;

  ColorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['color'] = color;
    return data;
  }
}
