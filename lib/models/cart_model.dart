class CartModel {
  CartModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
    required this.product,
    required this.cart,
  });
  late final int id;
  late final String createdAt;
  late final String updatedAt;
  late int quantity;
  late final int product;
  late final int cart;

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quantity = json['quantity'];
    product = json['product'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['quantity'] = quantity;
    data['product'] = product;
    data['cart'] = cart;
    return data;
  }

  increaseQuantity() {
    quantity++;
  }

  decreaseQuantity() {
    quantity--;
  }
}
