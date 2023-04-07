import 'package:clothing_ecommerce/data/app_urls.dart';

class CheckoutModel {
  CheckoutModel({
    required this.status,
    required this.statusCode,
    required this.datam,
    required this.message,
  });
  late final String status;
  late final int statusCode;
  late final List<Data> datam;
  late final String message;

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    datam = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['data'] = datam.map((e) => e.toJson()).toList();
    data['message'] = message;
    return data;
  }
}

class Data {
  Data({
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });
  late final Product product;
  late final int quantity;
  late final Size size;
  late final Color color;

  Data.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
    quantity = json['quantity'];
    size = Size.fromJson(json['size']);
    color = Color.fromJson(json['color']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product'] = product.toJson();
    data['quantity'] = quantity;
    data['size'] = size.toJson();
    data['color'] = color.toJson();
    return data;
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
  late final List<Sizes> sizes;
  late final List<Colors> colors;
  late final List<Stock> stock;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = AppUrl.baseUrl +  json['image'];
    category = Category.fromJson(json['category']);
    sizes = List.from(json['sizes']).map((e) => Sizes.fromJson(e)).toList();
    colors = List.from(json['colors']).map((e) => Colors.fromJson(e)).toList();
    stock = List.from(json['stock']).map((e) => Stock.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['category'] = category.toJson();
    data['sizes'] = sizes.map((e) => e.toJson()).toList();
    data['colors'] = colors.map((e) => e.toJson()).toList();
    data['stock'] = stock.map((e) => e.toJson()).toList();
    return data;
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
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}

class Sizes {
  Sizes({
    required this.id,
    required this.title,
  });
  late final int id;
  late final String title;

  Sizes.fromJson(Map<String, dynamic> json) {
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

class Colors {
  Colors({
    required this.id,
    required this.color,
  });
  late final int id;
  late final String color;

  Colors.fromJson(Map<String, dynamic> json) {
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
  late final Color color;
  late final String size;
  late final int quantity;

  Stock.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    color = Color.fromJson(json['color']);
    size = json['size'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product'] = product;
    data['color'] = color.toJson();
    data['size'] = size;
    data['quantity'] = quantity;
    return data;
  }
}

class Color {
  Color({
    required this.id,
    required this.color,
  });
  late final int id;
  late final String color;

  Color.fromJson(Map<String, dynamic> json) {
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

class Size {
  Size({
    required this.id,
    required this.title,
  });
  late final int id;
  late final String title;

  Size.fromJson(Map<String, dynamic> json) {
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
