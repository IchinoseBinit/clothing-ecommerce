import 'package:clothing_ecommerce/data/app_urls.dart';

class CartModel {
  CartModel({
    required this.product,
    required this.quantity,
    required this.cart,
  });
  late final Product product;
  late final int quantity;
  late final int cart;

  CartModel.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
    quantity = json['quantity'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product.toJson();
    _data['quantity'] = quantity;
    _data['cart'] = cart;
    return _data;
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.quantity,
    required this.sizeDataList,
    required this.colorDataList,
  });
  late final int id;
  late final String name;
  late final String description;
  late final int price;
  late final String image;
  late final int category;
  late int quantity;
  late SizeData sizeData;
  late ColorData colorData;
  late final List<SizeData> sizeDataList;
  late final List<ColorData> colorDataList;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = AppUrl.baseUrl + json['image'];
    category = json['category'];
    quantity = json['quantity'];
    sizeDataList =
        List.from(json['size']).map((e) => SizeData.fromJson(e)).toList();
    colorDataList =
        List.from(json['color']).map((e) => ColorData.fromJson(e)).toList();
    colorData = List.from(json['color'])
        .map((e) => ColorData.fromJson(e))
        .toList()
        .first;
    sizeData =
        List.from(json['size']).map((e) => SizeData.fromJson(e)).toList().first;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['price'] = price;
    _data['image'] = image;
    _data['category'] = category;
    _data['quantity'] = quantity;
    _data['size'] = sizeDataList.map((e) => e.toJson()).toList();
    _data['color'] = colorDataList.map((e) => e.toJson()).toList();
    return _data;
  }

  increaseQuantity() {
    quantity++;
  }

  decreaseQuantity() {
    quantity--;
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    return _data;
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
