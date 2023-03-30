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
  late final int size;
  bool isSelected = true;
  late final int color;

  CartModel.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
    quantity = json['quantity'];
    cart = json['cart'];
    size = json['size'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product.toJson();
    _data['quantity'] = quantity;
    _data['cart'] = cart;
    _data['size'] = size;
    _data['color'] = color;
    return _data;
  }

  increaseQuantity() {
    quantity++;
  }

  decreaseQuantity() {
    quantity--;
  }

  setSelectedCart({bool? value}) {
    isSelected = value ?? !isSelected;
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
    required this.sizes,
    required this.colors,
    required this.stock,
  });
  late final int id;
  late final String name;
  late final String description;
  late final int price;
  late final String image;
  late final Category category;
  late final List<SizeData> sizes;
  late final List<ColorData> colors;
  late final List<Stock> stock;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = AppUrl.baseUrl+json['image'];
    category = Category.fromJson(json['category']);
    sizes = List.from(json['sizes']).map((e) => SizeData.fromJson(e)).toList();
    colors = List.from(json['colors']).map((e) => ColorData.fromJson(e)).toList();
    stock = List.from(json['stock']).map((e) => Stock.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['price'] = price;
    _data['image'] = image;
    _data['category'] = category.toJson();
    _data['sizes'] = sizes.map((e) => e.toJson()).toList();
    _data['colors'] = colors.map((e) => e.toJson()).toList();
    _data['stock'] = stock.map((e) => e.toJson()).toList();
    return _data;
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
