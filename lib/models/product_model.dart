import 'package:clothing_ecommerce/data/app_urls.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.size,
    required this.color,
  });
  late final int id;
  late final String name;
  late final String description;
  late final int price;
  late final String image;
  late final List<SizeData> size;
  late final List<String> sizeList;
  late final List<ColorData> color;
  late final Category category;
  late final List<String> colorList;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = AppUrl.baseUrl + json['image'];
    category = Category.fromJson(json['category']);
    color = List.from(json['colors']).map((e) => ColorData.fromJson(e)).toList();
    colorList =
        List.from(json['colors']).map((e) => e["color"].toString()).toList();
    size = List.from(json['sizes']).map((e) => SizeData.fromJson(e)).toList();
    sizeList =
        List.from(json['sizes']).map((e) => e["title"].toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['category'] = category.toJson();
    data['sizes'] = size.map((e) => e.toJson()).toList();
    data['colors'] = color.map((e) => e.toJson()).toList();
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
class Stock {
  Stock({
    required this.product,
    required this.color,
    required this.size,
    required this.quantity,
  });
  late final int product;
  late final ColorData color;
  late final String size;
  late final int quantity;

  Stock.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    color = ColorData.fromJson(json['color']);
    size = json['size'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product;
    _data['color'] = color.toJson();
    _data['size'] = size;
    _data['quantity'] = quantity;
    return _data;
  }
}
class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String description;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['description'] = description;
    return _data;
  }
}
